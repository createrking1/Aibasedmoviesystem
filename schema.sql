-- Create database
CREATE DATABASE MovieRecommendationSystem;

-- Use the database
USE MovieRecommendationSystem;

-- Table for storing users
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for storing movies
CREATE TABLE Movies (
    MovieID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    ReleaseDate DATE,
    Description TEXT,
    Duration INT, -- Duration in minutes
    AverageRating DECIMAL(3, 2) DEFAULT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for storing genres
CREATE TABLE Genres (
    GenreID INT AUTO_INCREMENT PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL UNIQUE
);

-- Table for storing the relationship between movies and genres
CREATE TABLE MovieGenres (
    MovieID INT NOT NULL,
    GenreID INT NOT NULL,
    PRIMARY KEY (MovieID, GenreID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON DELETE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID) ON DELETE CASCADE
);

-- Table for storing user ratings for movies
CREATE TABLE Ratings (
    RatingID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    MovieID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Review TEXT,
    RatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON DELETE CASCADE
);

-- Table for storing user preferences (e.g., favorite genres)
CREATE TABLE UserPreferences (
    PreferenceID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    GenreID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID) ON DELETE CASCADE
);

-- Table for storing recommendations (optional)
CREATE TABLE Recommendations (
    RecommendationID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    MovieID INT NOT NULL,
    RecommendedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON DELETE CASCADE
);
