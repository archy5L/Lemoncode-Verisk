-- Listar las pistas ordenadas por el número de veces que aparecen en playlists de forma descendente

SELECT dbo.Track.Name, COUNT(*) AS Num_Rep FROM dbo.Track
INNER JOIN dbo.PlaylistTrack
ON dbo.Track.TrackId = dbo.PlaylistTrack.TrackId
INNER JOIN dbo.Playlist
ON dbo.PlaylistTrack.PlaylistId = dbo.Playlist.PlaylistId
GROUP BY dbo.Track.Name
ORDER BY Num_Rep DESC;

-- Listar las pistas más compradas (la tabla InvoiceLine tiene los registros de compras)

SELECT TOP 5 Name, COUNT(*) AS Num_Compras FROM dbo.Track
INNER JOIN dbo.InvoiceLine
ON dbo.Track.TrackId = dbo.InvoiceLine.TrackId
GROUP BY Name
ORDER BY Num_Compras DESC;

-- Listar los artistas más comprados

SELECT TOP 5 dbo.Artist.Name, COUNT(*) AS Num_Compras FROM dbo.Artist
INNER JOIN dbo.Album
ON dbo.Artist.ArtistId = dbo.Album.ArtistId
INNER JOIN dbo.Track
ON dbo.Album.AlbumId = dbo.Track.AlbumId
INNER JOIN dbo.InvoiceLine
ON dbo.Track.TrackId = dbo.InvoiceLine.TrackId
GROUP BY dbo.Artist.Name
ORDER BY Num_Compras DESC;

-- Listar las pistas que aún no han sido compradas por nadie

SELECT dbo.Track.Name FROM dbo.Track
FULL JOIN dbo.InvoiceLine
ON dbo.Track.TrackId = dbo.InvoiceLine.TrackId
WHERE Quantity IS NULL;

-- Listar los artistas que aún no han vendido ninguna pista

SELECT DISTINCT(dbo.Artist.Name), COUNT(dbo.InvoiceLine.Quantity) AS Num_Compras FROM dbo.Artist
FULL JOIN dbo.Album
ON dbo.Artist.ArtistId = dbo.Album.ArtistId
FULL JOIN dbo.Track
ON dbo.Album.AlbumId = dbo.Track.AlbumId
FULL JOIN dbo.InvoiceLine
ON dbo.Track.TrackId = dbo.InvoiceLine.TrackId
WHERE dbo.InvoiceLine.Quantity IS NULL
GROUP BY dbo.Artist.Name;
