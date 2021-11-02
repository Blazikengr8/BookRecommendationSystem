import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
import os
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import linear_kernel
from flask import Flask,request,jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
books = pd.read_csv('books.csv', encoding = "ISO-8859-1")
#books.head()
#books.shape
#books.columns
ratings = pd.read_csv('ratings.csv', encoding = "ISO-8859-1")
#ratings.head()

book_tags = pd.read_csv('book_tags.csv', encoding = "ISO-8859-1")
#book_tags.head()

tags = pd.read_csv('tags.csv')
#tags.tail()

tags_join_DF = pd.merge(book_tags, tags, left_on='tag_id', right_on='tag_id', how='inner')
#tags_join_DF.head()

to_read = pd.read_csv('to_read.csv')
#to_read.head()


# **TfidfVectorizer** function from scikit-learn, which transforms** text to feature vectors** that can be used as input to estimator.
# 
#  **Cosine Similarity** to calculate a numeric value that denotes the similarity between two books.

tf = TfidfVectorizer(analyzer='word',ngram_range=(1, 2),min_df=0, stop_words='english')
tfidf_matrix = tf.fit_transform(books['authors'])
cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)

#cosine_sim
# A function that returns the 20 most similar books based on the cosine similarity score.

# Build a 1-dimensional array with book titles
titles = books['title']
indices = pd.Series(books.index, index=books['title'])

# Function that get book recommendations based on the cosine similarity score of book authors
def authors_recommendations(title):
    idx = indices[title]
    sim_scores = list(enumerate(cosine_sim[idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:21]
    book_indices = [i[0] for i in sim_scores]
    #print(titles.iloc[book_indices])
    return titles.iloc[book_indices]




# Recommend books using the tags provided to the books.

books_with_tags = pd.merge(books, tags_join_DF, left_on='book_id', right_on='goodreads_book_id', how='inner')

# books_with_tags[(books_with_tags.goodreads_book_id==18710190)]['tag_name']

tf1 = TfidfVectorizer(analyzer='word',ngram_range=(1, 2),min_df=0, stop_words='english')
tfidf_matrix1 = tf1.fit_transform(books_with_tags['tag_name'].head(10000))
cosine_sim1 = linear_kernel(tfidf_matrix1, tfidf_matrix1)

#cosine_sim1

# Build a 1-dimensional array with book titles
titles1 = books['title']
indices1 = pd.Series(books.index, index=books['title'])

# Function that get book recommendations based on the cosine similarity score of books tags
def tags_recommendations(title):
    idx = indices1[title]
    sim_scores = list(enumerate(cosine_sim1[idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:21]
    book_indices = [i[0] for i in sim_scores]
    #print(titles.iloc[book_indices])
    return titles.iloc[book_indices]




# Recommendation of books using the authors and tags attributes for better results.
# Creating corpus of features and calculating the TF-IDF on the corpus of attributes for gettings better recommendations.


temp_df = books_with_tags.groupby('book_id')['tag_name'].apply(' '.join).reset_index()
#temp_df.head()


books = pd.merge(books, temp_df, left_on='book_id', right_on='book_id', how='inner')

#books.head()
books['corpus'] = (pd.Series(books[['authors', 'tag_name']]
                .fillna('')
                .values.tolist()
                ).str.join(' '))



tf_corpus = TfidfVectorizer(analyzer='word',ngram_range=(1, 2),min_df=0, stop_words='english')
tfidf_matrix_corpus = tf_corpus.fit_transform(books['corpus'])
cosine_sim_corpus = linear_kernel(tfidf_matrix_corpus, tfidf_matrix_corpus)

# Build a 1-dimensional array with book titles
titles = books['title']
indices = pd.Series(books.index, index=books['title'])

# Function that get book recommendations based on the cosine similarity score of books tags
def corpus_recommendations(title):
    idx = indices1[title]
    sim_scores = list(enumerate(cosine_sim_corpus[idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:21]
    book_indices = [i[0] for i in sim_scores]
    #print(titles.iloc[book_indices])
    return titles.iloc[book_indices]


# Function that get book recommendations based on the cosine similarity score of book authors
#authors_recommendations('The Hobbit').head(20)

# Function that get book recommendations based on the cosine similarity score of books tags
#tags_recommendations('The Hobbit').head(20)

# Function that get book recommendations based on the cosine similarity score of books tags
#corpus_recommendations("The Hobbit")

@app.route('/')
def home():
    return 'welcome to book recommendation system'

@app.route('/author')
def auth():
    name = request.args.get('name')
    recom = authors_recommendations(str(name)).head(3).tolist()
    #print(recom, type(recom))
    return jsonify(recom)

@app.route('/tag')
def tag():
    name = request.args.get('name')
    recom = tags_recommendations(str(name)).head(3).tolist()
    #print(recom, type(recom))
    return jsonify(recom)

@app.route('/corp')
def corp():
    name = request.args.get('name')
    recom = corpus_recommendations(str(name)).tolist()
    #print(recom, type(recom))
    return jsonify(recom)

if __name__ == '__main__':
    app.run()