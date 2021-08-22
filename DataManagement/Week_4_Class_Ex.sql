
USE stepchallenge;
# 1.	Retrieve a list of the names of participants. 
SELECT Name FROM Participant;

# 2.	List the names of all participants who have enrolled in more than 2 weekly challenges.  
SELECT Name FROM Participant
WHERE ParticipantID IN (SELECT ParticipantID FROM `Participant-WeeklyChallenge`
GROUP BY ParticipantID
HAVING  COUNT(WeeklyChallengeID) > 2);


# 3.	What is the number of participants who have redeemed at least one “Car Wash at Caltex”?  
SELECT COUNT(DISTINCT(ParticipantID)) AS PartAmt FROM Redemption
WHERE RewardID IN
(SELECT RewardID FROM reward
WHERE RewardName LIKE '%Car Wash%');



# 4.	List the names of participants who have accumulated more than 10,000 SC points and have redeemed at least one “Car Wash at Caltex”?  

SELECT Name FROM
(SELECT a.ParticipantID FROM
(
SELECT DISTINCT(ParticipantID) AS ParticipantID 
FROM Redemption
WHERE RewardID IN
(SELECT RewardID FROM reward
WHERE RewardName LIKE '%Car Wash%')
) AS a, 
(
SELECT ParticipantID FROM scpoint 
GROUP BY ParticipantID
HAVING  SUM(BasicPointsEarned) > 10000
) AS b
WHERE a.ParticipantID = b.ParticipantID
) AS PartID 
LEFT OUTER JOIN participant 
ON PartID.ParticipantID = participant.ParticipantID;










