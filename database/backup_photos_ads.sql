PGDMP     6    4                v         
   photos_ads    10.3    10.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false                       1262    17538 
   photos_ads    DATABASE     �   CREATE DATABASE photos_ads WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE photos_ads;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12973    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false                        0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    17539    lincks    TABLE     M   CREATE TABLE public.lincks (
    ads_id bigint NOT NULL,
    lincks jsonb
);
    DROP TABLE public.lincks;
       public         postgres    false    3            !           0    0    TABLE lincks    ACL     -   GRANT ALL ON TABLE public.lincks TO drovito;
            public       postgres    false    196                      0    17539    lincks 
   TABLE DATA               0   COPY public.lincks (ads_id, lincks) FROM stdin;
    public       postgres    false    196   �	       �
           2606    17546    lincks lincks_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.lincks
    ADD CONSTRAINT lincks_pkey PRIMARY KEY (ads_id);
 <   ALTER TABLE ONLY public.lincks DROP CONSTRAINT lincks_pkey;
       public         postgres    false    196               �   x�����@���������^EQ4� '�k�� �k�o2mg,��qy��kg�U|�&�9�]�.��6����w���Eq<T���(S��0�4�x1g��0x�K	H����j��'r���C O����yDVq��A��9=
�m�������s�71.�#?�#o��1���1���p2�������ο�Y'Q=����     