import sqlite3
import re

def convert_sqlite_to_mysql(sqlite_db_path, mysql_sql_path):
    # Connect to SQLite database
    conn = sqlite3.connect(sqlite_db_path)
    
    with open(mysql_sql_path, 'w', encoding='utf-8') as f:
        f.write("CREATE DATABASE IF NOT EXISTS `roomshare_db`;\n")
        f.write("USE `roomshare_db`;\n\n")
        f.write("SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';\n")
        f.write("START TRANSACTION;\n")
        f.write("SET time_zone = '+00:00';\n\n")
        
        # Get schema and data from sqlite
        for line in conn.iterdump():
            # Skip sqlite-specific commands
            if line.startswith('PRAGMA') or line.startswith('BEGIN TRANSACTION') or line.startswith('COMMIT') or 'sqlite_sequence' in line:
                continue
                
            # Replace sqlite-specific syntax with mysql-specific syntax
            # 'AUTOINCREMENT' -> 'AUTO_INCREMENT'
            line = re.sub(r'\bAUTOINCREMENT\b', 'AUTO_INCREMENT', line)
            
            # Remove double quotes around table/column names, optionally replace with backticks
            # Example: "users" -> `users`
            line = re.sub(r'"([^"]+)"', r'`\1`', line)
            
            # Simple sqlite integer primary key to mysql auto_increment
            line = re.sub(r'(?i)INTEGER PRIMARY KEY AUTO_INCREMENT', 'INT AUTO_INCREMENT PRIMARY KEY', line)
            line = re.sub(r'(?i)INTEGER PRIMARY KEY', 'INT AUTO_INCREMENT PRIMARY KEY', line)
            
            # Remove sqlite-specific DEFERRABLE
            line = line.replace(' DEFERRABLE INITIALLY DEFERRED', '')
            
            # Fix long identifier names (MySQL limit is 64 chars)
            # Find names inside backticks and truncate them if they are > 64 chars
            def truncate_ident(match):
                ident = match.group(1)
                if len(ident) > 64:
                    return f"`{ident[:60]}_idx`"
                return f"`{ident}`"
            
            line = re.sub(r'`([^`]+)`', truncate_ident, line)
            
            # Boolean mapping
            line = line.replace(' `is_superuser` bool NOT NULL', ' `is_superuser` tinyint(1) NOT NULL')
            line = line.replace(' `is_staff` bool NOT NULL', ' `is_staff` tinyint(1) NOT NULL')
            line = line.replace(' `is_active` bool NOT NULL', ' `is_active` tinyint(1) NOT NULL')
            
            # Let's just output the line
            f.write(line + "\n")
            
        f.write("\nCOMMIT;\n")

if __name__ == "__main__":
    convert_sqlite_to_mysql('db.sqlite3', 'database_dump.sql')
    print("Database dumped successfully to database_dump.sql")
