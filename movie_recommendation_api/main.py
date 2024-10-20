import numpy as np
from sklearn.neighbors import NearestNeighbors
from sklearn.decomposition import NMF
from db_connection import get_connection
from get_rated_movies import get_rated_movies


def get_data_from_db():
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM movies_rating")
    ratings = cursor.fetchall()

    cursor.execute("SELECT * FROM movies_movie")
    movies = cursor.fetchall()

    cursor.execute("SELECT * FROM movies_user")
    users = cursor.fetchall()

    conn.close()

    return ratings, movies, users


def get_user_ratings_count(user_id):
    """Count how many ratings a user has given."""
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT COUNT(*) FROM movies_rating WHERE user_id = %s", (user_id,))
    ratings_count = cursor.fetchone()[0]

    conn.close()

    return ratings_count


def recommend_using_knn(user_id, k=5):
    """Recommendation using KNN algorithm for new users."""
    ratings, movies, users = get_data_from_db()

    user_movie_matrix = np.zeros((len(users), len(movies)))

    for rating in ratings:
        user_index = rating[0] - 1  # Assuming user_id starts from 1
        movie_index = rating[1] - 1  # Assuming movie_id starts from 1
        user_movie_matrix[user_index][movie_index] = rating[2]

    knn = NearestNeighbors(metric='cosine', algorithm='brute')
    knn.fit(user_movie_matrix)

    distances, indices = knn.kneighbors(user_movie_matrix[user_id - 1].reshape(1, -1), n_neighbors=k + 1)

    recommendations = []
    for i in range(1, len(distances.flatten())):
        similar_user_id = indices.flatten()[i]
        similar_user_ratings = user_movie_matrix[similar_user_id]

        for movie_id, rating in enumerate(similar_user_ratings):
            if rating > 4.0 and user_movie_matrix[user_id - 1][movie_id] == 0:
                recommendations.append(movies[movie_id][1])

    return recommendations


def recommend_using_matrix_factorization(user_id):
    """Recommendation using Matrix Factorization (NMF) algorithm."""
    ratings, movies, users = get_data_from_db()

    user_movie_matrix = np.zeros((len(users), len(movies)))

    for rating in ratings:
        user_index = rating[0] - 1
        movie_index = rating[1] - 1
        user_movie_matrix[user_index][movie_index] = rating[2]

    # Matrix Factorization (NMF)
    nmf = NMF(n_components=15, init='random', random_state=42, max_iter=500)
    user_features = nmf.fit_transform(user_movie_matrix)
    movie_features = nmf.components_

    user_profile = user_features[user_id - 1]
    recommendations_scores = np.dot(user_profile, movie_features)

    recommendations = []
    user_rated_movies = user_movie_matrix[user_id - 1]

    for movie_id, score in enumerate(recommendations_scores):
        if user_rated_movies[movie_id] == 0:
            recommendations.append((movies[movie_id][1], score))

    recommendations = sorted(recommendations, key=lambda x: x[1], reverse=True)

    return [movie for movie, score in recommendations[:10]]


def hybrid_recommendation_system(user_id):
    """Hybrid recommendation system with information about the algorithm used."""
    ratings_count = get_user_ratings_count(user_id)

    if ratings_count <= 2:
        recommendations = recommend_using_knn(user_id)
        algorithm_used = "KNN"
    else:
        recommendations = recommend_using_matrix_factorization(user_id)
        algorithm_used = "Matrix Factorization (NMF)"

    return recommendations, algorithm_used


def add_to_favorites(user_id, movie_id):
    """Adds a movie to favorites for the user."""
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM movies_favorite WHERE user_id = %s AND movie_id = %s", (user_id, movie_id))
    result = cursor.fetchone()

    if result:
        print("Movie is already in favorites.")
    else:
        cursor.execute("INSERT INTO movies_favorite (user_id, movie_id) VALUES (%s, %s)", (user_id, movie_id))
        conn.commit()
        print(f"Movie ID {movie_id} has been added to favorites for user {user_id}.")

    conn.close()


def get_favorites(user_id):
    """Returns a list of favorite movies for the user."""
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT m.title 
        FROM movies_favorite f
        JOIN movies_movie m ON f.movie_id = m.id
        WHERE f.user_id = %s
    """, (user_id,))

    favorites = cursor.fetchall()
    conn.close()

    return [f[0] for f in favorites]


def get_all_movies():
    """Returns all movies from the database."""
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM movies_movie")
    movies = cursor.fetchall()

    conn.close()

    return movies


def rate_movie(user_id, movie_id, rating):
    """Adds a movie rating to the database."""
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM movies_rating WHERE user_id = %s AND movie_id = %s", (user_id, movie_id))
    result = cursor.fetchone()

    if result:
        print("Movie has already been rated by this user.")
    else:
        cursor.execute("INSERT INTO movies_rating (user_id, movie_id, rating) VALUES (%s, %s, %s)", (user_id, movie_id, rating))
        conn.commit()
        print(f"Movie ID {movie_id} has been rated {rating} by user {user_id}.")

    conn.close()


if __name__ == "__main__":
    user_id = int(input("Enter your user ID: "))

    while True:
        print("\nChoose an option:")
        print("1. Browse all movies")
        print("2. Rate a movie")
        print("3. Add movie to favorites")
        print("4. Get recommendations")
        print("5. View favorite movies")
        print("6. Exit")

        option = int(input("Choose an option (1-6): "))

        if option == 1:
            movies = get_all_movies()
            print("\nAll movies in the library:")
            for movie in movies:
                print(f"ID: {movie[0]}, Title: {movie[1]}, Genre: {movie[2]}")

        elif option == 2:
            movie_id = int(input("Enter movie ID to rate: "))
            rating = float(input("Enter rating (1-5): "))
            rate_movie(user_id, movie_id, rating)

        elif option == 3:
            movie_id = int(input("Enter movie ID to add to favorites: "))
            add_to_favorites(user_id, movie_id)

        elif option == 4:
            recommendations, algorithm_used = hybrid_recommendation_system(user_id)
            print(f"Recommendations for user {user_id} (algorithm: {algorithm_used}):")
            for movie in recommendations:
                print(movie)

        elif option == 5:
            favorites = get_favorites(user_id)
            print(f"Favorite movies for user {user_id}: {favorites}")

        elif option == 6:
            print("Thank you for using the recommendation system!")
            break

        else:
            print("Invalid option. Please try again.")
