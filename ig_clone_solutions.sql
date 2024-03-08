-- 1. Finding 5 oldest users

SELECT * FROM users ORDER BY created_at LIMIT 5;

-- 2. What day of the week d most users register on

SELECT DAYNAME(created_at) AS day, COUNT(*) AS total FROM users GROUP BY day ORDER BY total DESC;

-- 3. Find the user who have never posted a photo

SELECT username,image_url FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- 4. Most liked photo 

SELECT username, photos.id, photos.image_url, COUNT(*) AS likes FROM photos
JOIN likes ON likes.photo_id = photos.id
JOIN users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY likes DESC 
LIMIT 1;

-- 5. How any times does the average user post

SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users);

-- 6. Top 5 most used Hashtags

SELECT tags.tag_name, COUNT(*) AS total FROM photo_tags
JOIN tags On photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC 
LIMIT 5;

-- 7. Find user who have liked each and every photo

SELECT username, COUNT(*) AS total FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING total = (SELECT COUNT(*) FROM photos);