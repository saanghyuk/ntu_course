USE socialgram;
# 1.	List the names of users who are group moderators. 
SELECT name FROM user 
WHERE UserID IN (SELECT UserID FROM `user-group` WHERE isModerator = "Y");

# 2. List the names of users who are banned in more than 1 group.
SELECT name FROM user
WHERE
UserID IN
(SELECT UserID
FROM socialgram.`user-group`
GROUP BY UserID
HAVING Sum(IF(isBanned = "Y", 1, 0)) > 1);


# 3. List the names of users and total filesize of each user’s photos when the total filesize of his/her photos is larger than 1000.

SELECT User.name, FS.Total_Photo_Size FROM User
RIGHT OUTER JOIN
(SELECT `user-photo`.UserID, SUM(FileSize) AS Total_Photo_Size FROM `user-photo` 
LEFT OUTER JOIN Photo 
ON `user-photo`.PhotoID = Photo.PhotoID
GROUP BY `user-photo`.UserID
HAVING SUM(FileSize) > 1000) AS FS
ON User.UserID = FS.UserID;



# 4.	List the names of albums (and the number of users owning the album) in which at least one photo belongs to more than 1 users.
SELECT AlbumName, COUNT(*) AS total_users FROM album
WHERE PhotoID 
IN (SELECT PhotoID FROM album
GROUP BY PhotoID
HAVING COUNT(UserID) > 1)
GROUP BY AlbumName;


# 5. List the userid and user names of those who are following each other. For example, Ben Choi is following Jackie Tan and Jackie Tan is following Ben Choi. 

SELECT follow.UserID AS userid, us1.name AS userName, follow.FollowingUserID AS following_userid, us2.name AS following_userName
FROM
(SELECT u1.UserID, u1.FollowingUserID FROM `user-following` AS u1
LEFT OUTER JOIN `user-following`AS u2
ON u1.FollowingUserID = u2.UserID
WHERE u1.UserID = u2.FollowingUserID) AS follow
LEFT OUTER JOIN socialgram.user AS us1
ON follow.UserID = us1.UserID
LEFT OUTER JOIN socialgram.user AS us2
ON follow.FollowingUserID = us2.UserID;




# 6.	List the users who are involved in relational triads. 
# For example, Ben Choi is following Jayden Johnson, Jayden Johnson is following Cammy Soh, Cammy Soh is following Ben Choi. 
SELECT us1.name AS User1, us2.name AS User2, us3.name AS User3 FROM
(SELECT u1_userID, u2_userID, u3_userID FROM  
(SELECT 
u1.UserID AS u1_userID, u1.FollowingUserID AS u1_following,  
u2.UserID AS u2_userID, u2.FollowingUserID AS u2_following,  
u3.UserID AS u3_userID, u3.FollowingUserID AS u3_following
FROM `user-following` AS u1
LEFT OUTER JOIN `user-following`AS u2
ON u1.FollowingUserID = u2.UserID
LEFT OUTER JOIN `user-following` AS u3
ON u2.FollowingUserID = u3.UserID) AS  follow
WHERE u1_userID != u2_following
AND u2_userID != u3_following
AND u1_userID = u3_following) AS user_table
LEFT OUTER JOIN socialgram.user AS us1
ON u1_userID = us1.UserID
LEFT OUTER JOIN socialgram.user AS us2
ON u2_userID = us2.UserID
LEFT OUTER JOIN socialgram.user AS us3
ON u3_userID = us3.UserID
;
