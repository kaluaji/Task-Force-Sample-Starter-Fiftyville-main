-- Keep a log for all your Queries used to get the results
SELECT description FROM crime_scene_reports csr WHERE YEAR =2023 AND MONTH =7 AND DAY=28 AND street ='Humphrey Street';

--Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery.

SELECT transcript FROM interviews i WHERE YEAR =2023 AND MONTH =7 AND DAY=28 AND transcript LIKE '%bakery%';

--Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.     |
--I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                            |
--As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.

--using first transcript
SELECT name FROM people p 
JOIN bakery_security_logs bsl ON bsl.license_plate = p.license_plate
WHERE YEAR =2023 AND MONTH =7 AND DAY=28 AND HOUR =10 AND MINUTE >=15 AND MINUTE <=25;
--suspects:
--Vanes, Bruce, Barry, Luca , Sofia, Iman , Diana

--USING SECOND transcript
SELECT name FROM people p
JOIN bank_accounts ba ON ba.person_id = p.id 
JOIN atm_transactions at2 ON at2.account_number = ba.account_number 
WHERE YEAR =2023 AND MONTH =7 AND DAY=28 AND atm_location LIKE '%Leggett Street%' AND transaction_type = 'withdraw';
--suspects:
--Bruce , Diana , Brooke, Kenny , Iman  , Luca  , Taylor

--common suspects: Bruce , Diana , Iman  , Luca

--using third transcript
SELECT name FROM people p 
JOIN phone_calls pc ON pc.caller = p.phone_number 
WHERE YEAR =2023 AND MONTH =7 AND DAY=28 AND duration <=60;
--suspects:
--Sofia  , Kelsey , Bruce  , Kathryn, Kelsey , Taylor , Diana  , Carina , Kenny  , Benista

--common suspects: bruce, diana

SELECT name FROM people p 
JOIN passengers p2 ON p2.passport_number = p.passport_number 
WHERE flight_id = (
SELECT id FROM flights f WHERE YEAR =2023 AND MONTH =7 AND DAY=29 AND origin_airport_id=(
SELECT id FROM airports a WHERE full_name LIKE '%Fiftyville%'
) ORDER BY HOUR, MINUTE LIMIT 1
);
--suspects: Doris , Sofia , Bruce , Edward, Kelsey, Taylor, Kenny ,Luca

--comman suspect: Bruce

SELECT city FROM airports a WHERE id=(
SELECT destination_airport_id FROM flights f WHERE YEAR =2023 AND MONTH =7 AND DAY=29 AND origin_airport_id=(
SELECT id FROM airports a WHERE full_name LIKE '%Fiftyville%'
) ORDER BY HOUR, MINUTE LIMIT 1
);
--New York City

SELECT name FROM people p WHERE phone_number = (
SELECT receiver FROM phone_calls pc WHERE caller = (
SELECT phone_number FROM people p2 WHERE name LIKE '%Bruce%'
) AND YEAR =2023 AND MONTH =7 AND DAY=28 AND duration <=60
);

--Robin