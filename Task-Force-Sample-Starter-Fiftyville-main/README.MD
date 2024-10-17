# Task Force: Fiftyville - SQL Mystery

Welcome to **50ville**, a thrilling SQL mystery!

The CS50 Duck has been stolen! The town of Fiftyville has called upon you to solve the mystery of the stolen duck. Authorities believe that the thief stole the duck and then, shortly afterwards, took a flight out of town with the help of an accomplice. Your goal is to identify:

1. **The Thief** - Who committed the crime?
2. **The City** - Where did the thief escape to?
3. **The Accomplice** - Who helped the thief?

You have been provided with the `fiftyville.db` SQLite database file. Using SQL queries, you will explore the database to gather clues and solve the mystery.

All you know is that the theft took place on **July 28, 2023** and that it took place on **Humphrey Street**.

### How to Start

1. **Download the Database:**
   - The database file is named `fiftyville.db`. Make sure you have this file in your working directory.

2. **Install SQLite3:**
   - If you don’t have SQLite installed, follow the instructions below for your operating system.

   #### **Windows**:
   - Download the SQLite tools from the official SQLite website: [SQLite Download Page](https://www.sqlite.org/download.html).
   - Extract the zip file and copy the `.exe` files to a folder, such as `C:\sqlite`.
   - Add this folder to your system's PATH so you can run SQLite commands from any terminal:
     1. Open **Control Panel** > **System** > **Advanced system settings**.
     2. Click **Environment Variables**.
     3. Under **System Variables**, find the **Path** variable and click **Edit**.
     4. Add the path to the folder containing `sqlite3.exe`, like `C:\sqlite`.
   - Open **Command Prompt** and type `sqlite3` to ensure it’s working.

   #### **macOS**:
   - SQLite is pre-installed on macOS. To verify, open **Terminal** and type `sqlite3`.
   - If it’s not installed, you can use **Homebrew**:
     ```bash
     brew install sqlite3
     ```

   #### **Linux**:
   - SQLite is often pre-installed. If not, install it using your package manager:
     ```bash
     sudo apt install sqlite3
     ```

3. **Open the Database:**
   - Open a terminal (Command Prompt or Terminal) and navigate to the folder containing `fiftyville.db`. Run:
     ```bash
     sqlite3 fiftyville.db
     ```
   - This will open the SQLite interactive shell where you can run your SQL queries.

4. **Load the Schema**:
   - To see the tables and their structure, run:
     ```sql
     .tables
     ```
   - To view the schema of a specific table, use:
     ```sql
     PRAGMA table_info(table_name);
     ```
     Example: 
     ```sql
     PRAGMA table_info(crime_scene_reports);
     ```

### Task Overview

Your goal is to examine crime scene reports, interview records, bank transactions, phone calls, flight records, and more to piece together clues. 

You need to determine:
1. **Who the thief is**.
2. **Which city they escaped to**.
3. **Who helped the thief (the accomplice)**.

### Database Schema

Below is the structure of the tables in the database:

#### `crime_scene_reports`
| Column      | Type    | Description                        |
|-------------|---------|------------------------------------|
| id          | INTEGER | Unique report ID                   |
| year        | INTEGER | Year of the crime                  |
| month       | INTEGER | Month of the crime                 |
| day         | INTEGER | Day of the crime                   |
| street      | TEXT    | Street where the crime occurred    |
| description | TEXT    | Description of the crime           |

#### `interviews`
| Column      | Type    | Description                        |
|-------------|---------|------------------------------------|
| id          | INTEGER | Unique interview ID                |
| name        | TEXT    | Name of the person interviewed     |
| year        | INTEGER | Year of the interview              |
| month       | INTEGER | Month of the interview             |
| day         | INTEGER | Day of the interview               |
| transcript  | TEXT    | Transcript of the interview        |

#### `atm_transactions`
| Column          | Type    | Description                     |
|-----------------|---------|---------------------------------|
| id              | INTEGER | Unique transaction ID           |
| account_number  | INTEGER | Bank account number             |
| year            | INTEGER | Year of the transaction         |
| month           | INTEGER | Month of the transaction        |
| day             | INTEGER | Day of the transaction          |
| atm_location    | TEXT    | Location of the ATM used        |
| transaction_type| TEXT    | Type of transaction (withdrawal/deposit) |
| amount          | INTEGER | Amount involved in the transaction |

#### `bank_accounts`
| Column          | Type    | Description                     |
|-----------------|---------|---------------------------------|
| account_number  | INTEGER | Unique bank account number       |
| person_id       | INTEGER | ID of the person owning the account |
| creation_year   | INTEGER | Year the account was created     |

#### `airports`
| Column          | Type    | Description                     |
|-----------------|---------|---------------------------------|
| id              | INTEGER | Unique airport ID               |
| abbreviation    | TEXT    | Airport abbreviation            |
| full_name       | TEXT    | Full name of the airport        |
| city            | TEXT    | City where the airport is located|

#### `flights`
| Column               | Type    | Description                     |
|----------------------|---------|---------------------------------|
| id                   | INTEGER | Unique flight ID                |
| origin_airport_id     | INTEGER | Origin airport ID (foreign key) |
| destination_airport_id| INTEGER | Destination airport ID (foreign key) |
| year                 | INTEGER | Year of the flight              |
| month                | INTEGER | Month of the flight             |
| day                  | INTEGER | Day of the flight               |
| hour                 | INTEGER | Hour of the flight              |
| minute               | INTEGER | Minute of the flight            |

#### `passengers`
| Column          | Type    | Description                        |
|-----------------|---------|------------------------------------|
| flight_id       | INTEGER | Flight ID (foreign key)            |
| passport_number | INTEGER | Passenger’s passport number        |
| seat            | TEXT    | Seat number on the flight          |

#### `phone_calls`
| Column   | Type    | Description                     |
|----------|---------|---------------------------------|
| id       | INTEGER | Unique call ID                  |
| caller   | TEXT    | Phone number of the caller      |
| receiver | TEXT    | Phone number of the receiver    |
| year     | INTEGER | Year of the call                |
| month    | INTEGER | Month of the call               |
| day      | INTEGER | Day of the call                 |
| duration | INTEGER | Duration of the call (seconds)  |

#### `people`
| Column        | Type    | Description                     |
|---------------|---------|---------------------------------|
| id            | INTEGER | Unique person ID                |
| name          | TEXT    | Name of the person              |
| phone_number  | TEXT    | Phone number of the person      |
| passport_number | INTEGER | Person's passport number        |
| license_plate | TEXT    | License plate of the person’s vehicle |

#### `bakery_security_logs`
| Column        | Type    | Description                     |
|---------------|---------|---------------------------------|
| id            | INTEGER | Unique log ID                   |
| year          | INTEGER | Year of the log entry           |
| month         | INTEGER | Month of the log entry          |
| day           | INTEGER | Day of the log entry            |
| hour          | INTEGER | Hour of the log entry           |
| minute        | INTEGER | Minute of the log entry         |
| activity      | TEXT    | Recorded activity               |
| license_plate | TEXT    | Vehicle license plate involved  |

### Useful SQL Commands

You will need to run SQL queries to extract information from the database. Below are some essential SQL commands that might be helpful for your investigation:

- **SELECT**: Retrieve data from a database.
    ```sql
    SELECT * FROM table_name;
    ```

- **WHERE**: Filter records based on conditions.
    ```sql
    SELECT * FROM table_name WHERE condition;
    ```

- **JOIN**: Combine rows from two or more tables based on a related column.
    ```sql
    SELECT * FROM table1 JOIN table2 ON table1.column = table2.column;
    ```

- **ORDER BY**: Sort results by one or more columns.
    ```sql
    SELECT * FROM table_name ORDER BY column ASC/DESC;
    ```

For a full list of SQL commands, check out the SQL reference [here](https://www.w3schools.com/sql/sql_ref_keywords.asp).

---

Good luck with the investigation, and may your SQL sleuthing lead you to the truth!


(inspired by CS50)

