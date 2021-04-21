drop table if exists books;

create table books
(
    id     serial
        constraint books_pk
            primary key,
    title  varchar(100)          not null,
    author varchar(40),
    genre  varchar(40),
    read   boolean default false not null
);

create unique index books_title_index
    on books (title);
