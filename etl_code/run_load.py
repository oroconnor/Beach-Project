
from etl_code.run_load_helpers import *


def main():
    
    # load arguments from command line
    #   - loader name (which source/parser to use)
    #   - input file path (or URL)
    #   - optional file path for original (pdf or other raw) file
    args = parse_args()
   
    # get git commit hash
    git_commit = get_git_commit_or_unknown()

    # connect to database
    DATABASE_URL = "postgresql://owen@localhost/beach"
    conn = connect_to_postgres(DATABASE_URL)
    conn.autocommit = False

    # try to run the helper script and pull in data
    try:
        print("Starting load...")

    # if any errors, print them and fail gracefully
    except Exception as e:
        print(e)
        exit(1)

    finally:
        conn.close()
    
    
    # try to load data into the database, and add row to log table

    # if any errors, print errors and rollback transaction

    # if successful, commit transaction, and print success message

    # close database connection
