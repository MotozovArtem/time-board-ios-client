//
//  SQLScripts.swift
//  time-board
//
//  Created by Tianid on 29.05.2020.
//  Copyright © 2020 Tianid. All rights reserved.
//

let SQLScriptCreateASAccout = """
CREATE TABLE IF NOT EXISTS "ASAccount" (
"idi"    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
"uuid"    TEXT UNIQUE,
"login"    TEXT NOT NULL,
"email"    TEXT NOT NULL,
"first_name"    TEXT,
"second_name"    TEXT,
"creation_date"    TEXT,
"version"    INTEGER,
"icon_url"    TEXT
);
"""

let SQLScriptCreateTest = """
CREATE TABLE IF NOT EXISTS "Test" (
    "id"    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "TestName"    INTEGER NOT NULL
);
"""

let SQLScriptUpdateASAccount = """
UPDATE ASAccount SET
login = :login,
email = :email,
first_name = :firstName,
second_name = :secondName,
creation_date = :creationDate,
version = :version,
icon_url = :iconUrl
WHERE uuid = :uuid
"""
