import mysql.connector


def get_rated_movies(user_id):
    """Returns movies rated by a specific user."""
    connection = None  # Initialize the variable at the beginning
    try:
        # Connect to the database
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='',
            database='movie_recommendation'
        )

        cursor = connection.cursor()

        # SQL query to retrieve rated movies by the user
        query = """
        SELECT m.title, m.genre, r.rating
        FROM movies_movie m
        JOIN movies_rating r ON m.id = r.movie_id
        WHERE r.user_id = %s;
        """
        cursor.execute(query, (user_id,))

        # Fetch results
        rated_movies = cursor.fetchall()

        # Display rated movies
        if rated_movies:
            print(f"Movies rated by user ID {user_id}:")
            for movie in rated_movies:
                print(f"Title: {movie[0]}, Genre: {movie[1]}, Rating: {movie[2]}")
        else:
            print(f"User ID {user_id} has not rated any movies yet.")

    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        if connection and connection.is_connected():
            cursor.close()
            connection.close()
