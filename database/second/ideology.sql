/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2020/6/11 12:17:48                           */
/*==============================================================*/


drop table if exists author;
drop table if exists category;
drop table if exists course_ideological_material;
drop table if exists editing;
drop table if exists editor;
drop table if exists keyword;
drop table if exists material_category;
drop table if exists material_keyword;
drop table if exists material_subject;
drop table if exists multimedia_documents;
drop table if exists reader;
drop table if exists `subject`;
drop table if exists `view`;
drop table if exists writing;

/*==============================================================*/
/* Table: author                                                */
/*==============================================================*/
create table author
(
   author_id            int not null,
   author_name          varchar(256) not null,
   author_email         varchar(256),
   author_workplace     varchar(1000),
   primary key (author_id)
);

/*==============================================================*/
/* Table: category                                              */
/*==============================================================*/
create table category
(
   category_id          int not null,
   category_name        varchar(256) not null,
   primary key (category_id)
);

/*==============================================================*/
/* Table: course_ideological_material                           */
/*==============================================================*/
create table course_ideological_material
(
   material_id          int not null,
   title                varchar(256) not null,
   `source`              varchar(256) not null,
   summary              varchar(10000),
   primary key (material_id)
);

/*==============================================================*/
/* Table: editing                                               */
/*==============================================================*/
create table editing
(
   material_id          int not null,
   editor_id            int not null,
   editor_date          date,
   primary key (material_id, editor_id)
);

/*==============================================================*/
/* Table: editor                                                */
/*==============================================================*/
create table editor
(
   editor_id            int not null,
   editor_name          varchar(256) not null,
   editor_email         varchar(256),
   editor_workplace     varchar(1000),
   primary key (editor_id)
);

/*==============================================================*/
/* Table: keyword                                               */
/*==============================================================*/
create table keyword
(
   keyword_id           int not null,
   keyword_name         varchar(256) not null,
   primary key (keyword_id)
);

/*==============================================================*/
/* Table: material_category                                     */
/*==============================================================*/
create table material_category
(
   material_id          int not null,
   category_id          int not null,
   primary key (material_id, category_id)
);

/*==============================================================*/
/* Table: material_keyword                                      */
/*==============================================================*/
create table material_keyword
(
   material_id          int not null,
   keyword_id           int not null,
   primary key (material_id, keyword_id)
);

/*==============================================================*/
/* Table: material_subject                                      */
/*==============================================================*/
create table material_subject
(
   subject_id           int not null,
   material_id          int not null,
   primary key (subject_id, material_id)
);

/*==============================================================*/
/* Table: multimedia_documents                                  */
/*==============================================================*/
create table multimedia_documents
(
   material_id          int not null,
   document_id          int not null,
   document_type        varchar(256) not null,
   document_method      varchar(256) not null,
   primary key (material_id, document_id)
);

/*==============================================================*/
/* Table: reader                                                */
/*==============================================================*/
create table reader
(
   reader_id            int not null,
   reader_name          varchar(256) not null,
   reader_email         varchar(256),
   primary key (reader_id)
);

/*==============================================================*/
/* Table: subject                                               */
/*==============================================================*/
create table `subject`
(
   subject_id           int not null,
   subject_parent_id    int,
   subject_name         varchar(256),
   primary key (subject_id)
);

/*==============================================================*/
/* Table: view                                                  */
/*==============================================================*/
create table `view`
(
   material_id          int not null,
   reader_id            int not null,
   view_times           int,
   primary key (material_id, reader_id)
);

/*==============================================================*/
/* Table: writing                                               */
/*==============================================================*/
create table writing
(
   material_id          int not null,
   author_id            int not null,
   write_date           date,
   primary key (material_id, author_id)
);

alter table editing add constraint FK_editing foreign key (material_id)
      references course_ideological_material (material_id) on delete restrict on update restrict;

alter table editing add constraint FK_editing2 foreign key (editor_id)
      references editor (editor_id) on delete restrict on update restrict;

alter table material_category add constraint FK_material_category foreign key (material_id)
      references course_ideological_material (material_id) on delete restrict on update restrict;

alter table material_category add constraint FK_material_category2 foreign key (category_id)
      references category (category_id) on delete restrict on update restrict;

alter table material_keyword add constraint FK_material_keyword foreign key (material_id)
      references course_ideological_material (material_id) on delete restrict on update restrict;

alter table material_keyword add constraint FK_material_keyword2 foreign key (keyword_id)
      references keyword (keyword_id) on delete restrict on update restrict;

alter table material_subject add constraint FK_material_subject foreign key (subject_id)
      references subject (subject_id) on delete restrict on update restrict;

alter table material_subject add constraint FK_material_subject2 foreign key (material_id)
      references course_ideological_material (material_id) on delete restrict on update restrict;

alter table multimedia_documents add constraint FK_material_document foreign key (material_id)
      references course_ideological_material (material_id) on delete restrict on update restrict;

alter table view add constraint FK_view foreign key (material_id)
      references course_ideological_material (material_id) on delete restrict on update restrict;

alter table view add constraint FK_view2 foreign key (reader_id)
      references reader (reader_id) on delete restrict on update restrict;

alter table writing add constraint FK_writing foreign key (material_id)
      references course_ideological_material (material_id) on delete restrict on update restrict;

alter table writing add constraint FK_writing2 foreign key (author_id)
      references author (author_id) on delete restrict on update restrict;

