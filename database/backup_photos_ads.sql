PGDMP                 	        v         
   photos_ads    9.6.6    10.4     J           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            K           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            L           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            M           1262    19771 
   photos_ads    DATABASE     �   CREATE DATABASE photos_ads WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE photos_ads;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            N           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12387    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            O           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    19772    lincks    TABLE     M   CREATE TABLE public.lincks (
    ads_id bigint NOT NULL,
    lincks jsonb
);
    DROP TABLE public.lincks;
       public         postgres    false    3            P           0    0    TABLE lincks    ACL     -   GRANT ALL ON TABLE public.lincks TO drovito;
            public       postgres    false    185            G          0    19772    lincks 
   TABLE DATA               0   COPY public.lincks (ads_id, lincks) FROM stdin;
    public       postgres    false    185   �	       �           2606    19779    lincks lincks_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.lincks
    ADD CONSTRAINT lincks_pkey PRIMARY KEY (ads_id);
 <   ALTER TABLE ONLY public.lincks DROP CONSTRAINT lincks_pkey;
       public         postgres    false    185            G   �   x���1�0Egr�*3J�I(@b�]� ���T�g�=C���取��'��]�Mw�:�U��W�S%u�ڦ���_�A�uz���L#�Q�x�߆9����( ��U�2�A�
��ܬ20S�Im�ͿA�2�)BO��BQ[QX��=C��P�yy�
��W�WB�S}x�     