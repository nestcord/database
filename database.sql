-- Create Users Table
CREATE TABLE users (
    id bigint primary key generated always as identity,
    username text not null unique,
    email text not null unique,
    password_hash text not null,
    created_at timestamp with time zone default now(),
    name text not null
);

-- Create Posts Table
CREATE TABLE posts (
    id bigint primary key generated always as identity,
    user_id bigint references users(id) on delete cascade,
    content text not null,
    created_at timestamp with time zone default now()
);

-- Create Followers Table
CREATE TABLE followers (
    follower_id bigint references users(id) on delete cascade,
    followee_id bigint references users(id) on delete cascade,
    primary key (follower_id, followee_id)
);

-- Create Likes Table
CREATE TABLE likes (
    user_id bigint references users(id) on delete cascade,
    post_id bigint references posts(id) on delete cascade,
    primary key (user_id, post_id)
);

-- Create Reposts Table
CREATE TABLE reposts (
    user_id bigint references users(id) on delete cascade,
    post_id bigint references posts(id) on delete cascade,
    primary key (user_id, post_id)
);

-- Create Stories Table
CREATE TABLE stories (
    id bigint primary key generated always as identity,
    user_id bigint references users(id) on delete cascade,
    content text not null,
    created_at timestamp with time zone default now(),
    expires_at timestamp with time zone not null,
    CONSTRAINT check_expiration CHECK (expires_at = created_at + interval '24 hours')
);
