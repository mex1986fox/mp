PGDMP     9    +                v         
   photos_ads    10.3    10.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false                       1262    17736 
   photos_ads    DATABASE     �   CREATE DATABASE photos_ads WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE photos_ads;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12973    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false                        0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    17745    lincks    TABLE     M   CREATE TABLE public.lincks (
    ads_id bigint NOT NULL,
    lincks jsonb
);
    DROP TABLE public.lincks;
       public         postgres    false    3            !           0    0    TABLE lincks    ACL     -   GRANT ALL ON TABLE public.lincks TO drovito;
            public       postgres    false    196                      0    17745    lincks 
   TABLE DATA               0   COPY public.lincks (ads_id, lincks) FROM stdin;
    public       postgres    false    196   �	       �
           2606    17752    lincks lincks_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.lincks
    ADD CONSTRAINT lincks_pkey PRIMARY KEY (ads_id);
 <   ALTER TABLE ONLY public.lincks DROP CONSTRAINT lincks_pkey;
       public         postgres    false    196               �   x����
�0D��+J��䦹7���"Z�KL��]�VWM�g�3�z��y��U.�U}���t��}n8�u�	�%�Qm�4Y�i�J�N�x#e���o��d�Cߺ�%�Ys�x�e�Q����1c��(	h��g�k�@z�Oc/"6�F     