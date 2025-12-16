import psycopg
from datetime import datetime, timezone

def parse_args():
    return None


def get_git_commit_or_unknown():
    return "unknown"


def connect_to_postgres(dsn):
    return psycopg.connect(dsn)

def insert_etl_log(conn, source_doc_id, helper_code, git_commit_hash):
    sql = """
        INSERT INTO etl_logs (
            etl_start_datetime,
            source_doc_id,
            helper_code,
            git_commit_hash
        )
        VALUES (%s, %s, %s, %s)
        RETURNING etl_log_id;
    """

    with conn.cursor() as cur:
        cur.execute(
            sql,
            (
                datetime.now(timezone.utc),
                source_doc_id,
                helper_code,
                git_commit_hash,
            )
        )
        etl_log_id = cur.fetchone()[0]

    return etl_log_id