# using streamlet for website
import pickle

import pandas as pd
import streamlit as st
import requests

#For Fetching api This library is used

# recommend function
def fetch_poster(movie_id):
    url = "https://api.themoviedb.org/3/movie/{}?api_key=b7c9b64eb0de08eadf6b68e9e933a259".format(
        movie_id)
    data = requests.get(url)
    data = data.json()
    poster_path = data['poster_path']
    full_path = "https://image.tmdb.org/t/p/original/" + poster_path
    return full_path

def recommend(movie):
    movie_index = movies[movies['title'] == movie].index[0]
    distances = similarity[movie_index]
    movie_list = sorted(list(enumerate(distances)), reverse=True, key=lambda x: x[1])[1:6]

    recommended_movies = []
    recommended_movies_movies_posters= []
    for i in movie_list:
        movie_id = movies.iloc[i[0]].movie_id
        recommended_movies.append(movies.iloc[i[0]].title)
        # poster Fetch from api
        recommended_movies_movies_posters.append(fetch_poster(movie_id))
    return recommended_movies,recommended_movies_movies_posters


movie_dict = pickle.load(open('movie_dict.pkl','rb'))
movies = pd.DataFrame(movie_dict)

similarity = pickle.load(open('similarity.pkl','rb'))

st.title('Movie Recomender system')

selected_movie_name = st.selectbox(
    'Enter Movie Name: ',
    movies['title'].values)

if st.button('Recommend'):
    movies_name,movies_posters = recommend(selected_movie_name)

    # display with the columns
    col1, col2, col3, col4, col5 = st.columns(5)
    with col1:
        st.text(movies_name[0])
        st.image(movies_posters[0])
    with col2:
        st.text(movies_name[1])
        st.image(movies_posters[1])
    with col3:
        st.text(movies_name[2])
        st.image(movies_posters[2])
    with col4:
        st.text(movies_name[3])
        st.image(movies_posters[3])
    with col5:
        st.text(movies_name[4])
        st.image(movies_posters[4])
