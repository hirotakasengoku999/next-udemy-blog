/*
 Warnings:
 
 - You are about to drop the column `conent` on the `Post` table. All the data in the column will be lost.
 - Added the required column `content` to the `Post` table without a default value. This is not possible if the table is not empty.
 
 */
-- RedefineTables
PRAGMA defer_foreign_keys = ON;

PRAGMA foreign_keys = OFF;

CREATE TABLE "new_Post" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "title" TEXT NOT NULL,
  "content" TEXT NOT NULL,
  "topImage" TEXT,
  "published" BOOLEAN NOT NULL DEFAULT true,
  "authorId" TEXT NOT NULL,
  "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" DATETIME NOT NULL,
  CONSTRAINT "Post_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO
  "new_Post" (
    "authorId",
    "createdAt",
    "id",
    "published",
    "title",
    "topImage",
    "updatedAt"
  )
SELECT
  "authorId",
  "createdAt",
  "id",
  "published",
  "title",
  "topImage",
  "updatedAt"
FROM
  "Post";

DROP TABLE "Post";

ALTER TABLE
  "new_Post" RENAME TO "Post";

PRAGMA foreign_keys = ON;

PRAGMA defer_foreign_keys = OFF;