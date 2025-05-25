PostgreSQL হলো একটি অত্যন্ত উন্নত RDBMS, যা ACID-compliant, MVCC (Multi-Version Concurrency Control) ব্যবহার করে এবং SQL সহ NoSQL বৈশিষ্ট্য সমর্থন করে। এর মূল লক্ষ্য ডাটা ইন্টিগ্রিটি, নিরাপত্তা, এবং স্কেলেবিলিটি নিশ্চিত করা।

👉 PostgreSQL-এর সংক্ষিপ্ত ইতিহাস: ✅ ১৯৮৬ সালে শুরু হয়েছিল POSTGRES নামে। ✅ পরে SQL সমর্থন যোগ হওয়ায় PostgreSQL নামে পরিচিত হয়। ✅ বর্তমানে এটি ব্যাংকিং, ই-কমার্স, বিশ্লেষণাত্মক ডাটা প্রসেসিং-এ ব্যবহৃত হয়।

## PostgreSQL কী?

PostgreSQL হল একটি ওপেন-সোর্স, রিলেশনাল ডাটাবেজ ম্যানেজমেন্ট সিস্টেম (RDBMS), যা শক্তিশালী, নির্ভরযোগ্য এবং স্কেলযোগ্য। এটি ACID (Atomicity, Consistency, Isolation, Durability) মানসম্পন্ন, যার ফলে
ট্রান্সেকশনগুলো নিরাপদ থাকে।

### ✨ PostgreSQL-এর কিছু বৈশিষ্ট্য:

1. একাধিক ডেটাটাইপ সাপোর্ট: স্ট্রিং, সংখ্যা, JSON, XML, GIS (PostGIS) ইত্যাদি।
2. উন্নত SQL ফিচার: WINDOW FUNCTIONS, CTE, JSONB ইত্যাদি।
3. একাধিক কনকারেন্ট ইউজার সাপোর্ট: MVCC (Multi-Version Concurrency Control) ব্যবহার করে।
4. স্ট্রং কাস্টমাইজেশন ক্ষমতা: ইউজার ডিফাইন্ড ফাংশন (UDF), ভিউ, ট্রিগার ব্যবহার করা যায়।
5. এক্সটেনশন সাপোর্ট: PostGIS, pgcrypto, hstore, এবং আরও অনেক।

### 🏆 উদাহরণ: PostgreSQL ডাটাবেজ তৈরি করা

```sql
    CREATE DATABASE wildlife_conservation;
```

এই কমান্ডটি একটি নতুন ডাটাবেজ তৈরি করবে।

## PostgreSQL-এ ডাটাবেজ স্কিমার উদ্দেশ্য কী?

একটি ডাটাবেজ স্কিমা মূলত ডাটার সংগঠন ও স্ট্রাকচার নির্ধারণের একটি পদ্ধতি। এটি টেবিল, ভিউ, ইনডেক্স, ট্রিগার ইত্যাদির কাঠামো সংরক্ষণ করে।

### ✨ স্কিমার সুবিধাসমূহ:

-   ডাটাকে বিভক্তভাবে সংরক্ষণ করা যায়, যাতে বিভিন্ন ইউজার বা অ্যাপ আলাদা ডাটা ম্যানেজ করতে পারে।
-   নামের সংঘর্ষ এড়ানো যায় (যেমন public.users vs admin.users)।
-   একই ডাটাবেজে একাধিক স্কিমা রাখা যায়, যা মডিউলার ডিজাইন সহজ করে।

### 🏆 উদাহরণ: নতুন স্কিমা তৈরি করা

```sql
    CREATE SCHEMA wildlife;
```

এটি wildlife নামে একটি স্কিমা তৈরি করবে যেখানে আমরা সংরক্ষণ-সংক্রান্ত ডাটা রাখতে পারি।

## PostgreSQL-এ Primary Key এবং Foreign Key কী?

-   এটি টেবিলের প্রতিটি রেকর্ডকে ইউনিক ও সনাক্তযোগ্য করে।
-   সাধারণত এটি AUTO_INCREMENT বা SERIAL টাইপের হয়।

## Foreign Key (FK):

এটি একটি টেবিলের সাথে অন্য টেবিলের সম্পর্ক স্থাপন করে। এটি Primary Key-এর মান রেফারেন্স করে যাতে ডাটার Integrity বজায় থাকে।

### 🏆 উদাহরণ: Primary Key এবং Foreign Key সংযোগ

```sql
    CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(50)
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers(ranger_id),
    species_id INT REFERENCES species(species_id),
    sighting_time TIMESTAMP
);

```

এখানে:

-   ranger_id হলো rangers টেবিলের Primary Key।
-   ranger_id এবং species_id হলো sightings টেবিলে Foreign Key, যা rangers ও species টেবিলকে রেফারেন্স করছে।

## VARCHAR বনাম CHAR-এর পার্থক্য কী?

PostgreSQL-এ VARCHAR এবং CHAR হলো স্ট্রিং ডেটাটাইপ, কিন্তু এদের ব্যবহারের ক্ষেত্রে কিছু পার্থক্য আছে।

### ✨ VARCHAR vs CHAR তুলনা:

| বৈশিষ্ট্য      | VARCHAR(N)                                   | CHAR(N)                                    |
| -------------- | -------------------------------------------- | ------------------------------------------ |
| ডাটা স্টোরেজ   | শুধুমাত্র লিখিত ক্যারেক্টারের জন্য জায়গা নেয় | সর্বদা নির্দিষ্ট N ক্যারেক্টার সংরক্ষণ করে |
| পারফরম্যান্স   | CHAR অপেক্ষা ভালো পারফর্ম করে বড় ডাটার জন্য  | ছোট ডাটার ক্ষেত্রে দ্রুত অ্যাক্সেস         |
| ব্যবহারযোগ্যতা | ডায়নামিক লেন্থের জন্য ভালো                   | নির্দিষ্ট লেন্থ সংরক্ষণের জন্য ভালো        |

###🏆 উদাহরণ: VARCHAR বনাম CHAR

```sql
CREATE TABLE species (
    common_name VARCHAR(50),     -- ডায়নামিক লেন্থ (50 ক্যারেক্টার পর্যন্ত)
    scientific_name CHAR(30)     -- ফিক্সড লেন্থ (30 ক্যারেক্টার)
);

```

এখানে:

-   VARCHAR(50) common_name-এর জন্য ব্যবহার করা হয়েছে, যাতে ছোট বা বড় নাম স্টোর করা যায়।
-   CHAR(30) scientific_name-এর জন্য, যাতে নির্দিষ্ট লেন্থ নিশ্চিত করা যায়।

## PostgreSQL-এ WHERE ক্লজের উদ্দেশ্য কী?

WHERE ক্লজ সুনির্দিষ্ট রেকর্ড ফিল্টার করতে সাহায্য করে। এটি SELECT, UPDATE, DELETE-এ ব্যবহার হয়।

### 🏆 উদাহরণ: WHERE ক্লজ ব্যবহার

```sql
SELECT * FROM sightings WHERE location LIKE '%Pass%';
```

এটি সকল sightings রিটার্ন করবে যেখানে location-এ "Pass" শব্দটি আছে।

## What to Submit

-   Public Github Repo Link :
