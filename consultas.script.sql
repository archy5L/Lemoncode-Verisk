-- Listar las pistas (tabla Track) con precio mayor o igual a 1€

SELECT * FROM dbo.Track
WHERE UnitPrice >= 1;

-- Listar las pistas de más de 4 minutos de duración

SELECT * FROM dbo.Track
WHERE Milliseconds > 240000;

-- Listar las pistas que tengan entre 2 y 3 minutos de duración

SELECT * FROM dbo.Track
WHERE Milliseconds BETWEEN 120000 AND 180000;

-- Listar las pistas que uno de sus compositores (columna Composer) sea Mercury

SELECT * FROM dbo.Track
WHERE Composer LIKE '%Mercury%';

-- Calcular la media de duración de las pistas (Track) de la plataforma

SELECT AVG(Milliseconds) FROM dbo.Track;

-- Listar los clientes (tabla Customer) de USA, Canada y Brazil

SELECT * FROM dbo.Customer
WHERE Country IN ('USA', 'Canada', 'Brazil');

-- Listar todas las pistas del artista 'Queen' (Artist.Name = 'Queen')

SELECT * FROM dbo.Album 
INNER JOIN dbo.Artist
ON dbo.Album.ArtistId = dbo.Artist.ArtistId
INNER JOIN dbo.Track
ON dbo.Album.AlbumId = dbo.Track.AlbumId
WHERE dbo.Artist.Name = 'Queen';

-- Listar las pistas del artista 'Queen' en las que haya participado como compositor David Bowie

SELECT * FROM dbo.Album 
INNER JOIN dbo.Artist
ON dbo.Album.ArtistId = dbo.Artist.ArtistId
INNER JOIN dbo.Track
ON dbo.Album.AlbumId = dbo.Track.AlbumId
WHERE dbo.Artist.Name = 'Queen'
AND dbo.Track.Composer LIKE '%David Bowie%';

-- Listar las pistas de la playlist 'Heavy Metal Classic'

SELECT * FROM dbo.PlaylistTrack
INNER JOIN dbo.Playlist
ON dbo.PlaylistTrack.PlaylistId = dbo.Playlist.PlaylistId
INNER JOIN dbo.Track
ON dbo.PlaylistTrack.TrackId = dbo.Track.TrackId
WHERE dbo.Playlist.Name = 'Heavy Metal Classic';

-- Listar las playlist junto con el número de pistas que contienen -- MAL!!

SELECT dbo.Playlist.Name, COUNT(*) FROM dbo.Playlist
INNER JOIN dbo.PlaylistTrack
ON dbo.Playlist.PlaylistId = dbo.PlaylistTrack.PlaylistId
INNER JOIN dbo.Track
ON dbo.PlaylistTrack.TrackId = dbo.Track.TrackId
GROUP BY dbo.Playlist.Name;

-- Listar las playlist (sin repetir ninguna) que tienen alguna canción de AC/DC

SELECT DISTINCT(dbo.Playlist.Name) FROM dbo.Playlist
INNER JOIN dbo.PlaylistTrack
ON dbo.Playlist.PlaylistId = dbo.PlaylistTrack.PlaylistId
INNER JOIN dbo.Track
ON dbo.PlaylistTrack.TrackId = dbo.Track.TrackId
WHERE Composer = 'AC/DC';


-- Listar las playlist que tienen alguna canción del artista Queen, junto con la cantidad que tienen

SELECT dbo.Playlist.Name, COUNT(dbo.Playlist.Name) FROM dbo.Playlist
INNER JOIN dbo.PlaylistTrack
ON dbo.Playlist.PlaylistId = dbo.PlaylistTrack.PlaylistId
INNER JOIN dbo.Track
ON dbo.PlaylistTrack.TrackId = dbo.Track.TrackId
WHERE Composer = 'Queen'
GROUP BY dbo.Playlist.Name;

-- Listar las pistas que no están en ninguna playlist

SELECT T.Name, COUNT(*) AS Playlist FROM dbo.Track T
FULL JOIN dbo.PlaylistTrack P
ON T.TrackId = P.TrackId
FULL JOIN dbo.Playlist L
ON P.PlaylistId = L.PlaylistId
GROUP BY T.Name
HAVING COUNT(*) = 0;

-- Listar los artistas que no tienen album

SELECT Name FROM dbo.Artist
INNER JOIN dbo.Album
ON dbo.Artist.ArtistId = dbo.Album.ArtistId
WHERE dbo.Album.ArtistId IS NULL;

-- Listar los artistas con el número de albums que tienen

SELECT Name, COUNT(*) AS Num_Albums FROM dbo.Artist
INNER JOIN dbo.Album
ON dbo.Artist.ArtistId = dbo.Album.ArtistId
GROUP BY dbo.Artist.Name;