PGDMP     '    +                v            drovito    10.3    10.3 \    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    18022    drovito    DATABASE     �   CREATE DATABASE drovito WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE drovito;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12973    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    18023    ads    TABLE     �  CREATE TABLE public.ads (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    settlements_id smallint NOT NULL,
    model_id smallint NOT NULL,
    body_id smallint,
    drive_id smallint,
    fuel_id smallint,
    transmission_id smallint,
    wheel character varying(1),
    engin_volume smallint,
    engin_power smallint,
    year smallint NOT NULL,
    price money NOT NULL,
    mileage numeric(8,0),
    description text,
    documentation boolean,
    repair boolean,
    exchange boolean
);
    DROP TABLE public.ads;
       public         drovito    false    3            �            1259    18029 
   ads_id_seq    SEQUENCE     s   CREATE SEQUENCE public.ads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.ads_id_seq;
       public       drovito    false    196    3            �           0    0 
   ads_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE public.ads_id_seq OWNED BY public.ads.id;
            public       drovito    false    197            �            1259    18031    locations_countries    TABLE     �   CREATE TABLE public.locations_countries (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    name_url character varying(32) NOT NULL
);
 '   DROP TABLE public.locations_countries;
       public         postgres    false    3            �           0    0    TABLE locations_countries    ACL     :   GRANT ALL ON TABLE public.locations_countries TO drovito;
            public       postgres    false    198            �            1259    18034    locations_settlements    TABLE     �   CREATE TABLE public.locations_settlements (
    id integer NOT NULL,
    subject_id integer NOT NULL,
    name character varying(64) NOT NULL,
    name_url character varying(64) NOT NULL
);
 )   DROP TABLE public.locations_settlements;
       public         postgres    false    3            �           0    0    TABLE locations_settlements    ACL     <   GRANT ALL ON TABLE public.locations_settlements TO drovito;
            public       postgres    false    199            �            1259    18037    locations_subjects    TABLE     j  CREATE TABLE public.locations_subjects (
    id integer NOT NULL,
    country_id integer NOT NULL,
    subject_number smallint NOT NULL,
    name character varying(64) NOT NULL,
    name_general character varying(64) NOT NULL,
    name_url character varying(32) NOT NULL,
    name_rp character varying(64) NOT NULL,
    name_pp character varying(64) NOT NULL
);
 &   DROP TABLE public.locations_subjects;
       public         postgres    false    3            �           0    0    TABLE locations_subjects    ACL     9   GRANT ALL ON TABLE public.locations_subjects TO drovito;
            public       postgres    false    200            �            1259    18040 
   transports    TABLE     �   CREATE TABLE public.transports (
    id integer NOT NULL,
    name character varying(32),
    name_url character varying(32)
);
    DROP TABLE public.transports;
       public         postgres    false    3            �           0    0    TABLE transports    ACL     1   GRANT ALL ON TABLE public.transports TO drovito;
            public       postgres    false    201            �            1259    18043    transports_bodies    TABLE     �   CREATE TABLE public.transports_bodies (
    id integer NOT NULL,
    transport_id integer,
    name character varying(32),
    name_url character varying(32)
);
 %   DROP TABLE public.transports_bodies;
       public         postgres    false    3            �           0    0    TABLE transports_bodies    ACL     8   GRANT ALL ON TABLE public.transports_bodies TO drovito;
            public       postgres    false    202            �            1259    18046    transports_brands    TABLE     �   CREATE TABLE public.transports_brands (
    id integer NOT NULL,
    transport_id integer,
    name character varying(32),
    name_url character varying(32)
);
 %   DROP TABLE public.transports_brands;
       public         postgres    false    3            �           0    0    TABLE transports_brands    ACL     8   GRANT ALL ON TABLE public.transports_brands TO drovito;
            public       postgres    false    203            �            1259    18049    transports_drives    TABLE     �   CREATE TABLE public.transports_drives (
    id integer NOT NULL,
    transport_id integer,
    name character varying(32),
    name_url character varying(32)
);
 %   DROP TABLE public.transports_drives;
       public         postgres    false    3            �           0    0    TABLE transports_drives    ACL     8   GRANT ALL ON TABLE public.transports_drives TO drovito;
            public       postgres    false    204            �            1259    18052    transports_fuels    TABLE     �   CREATE TABLE public.transports_fuels (
    id integer NOT NULL,
    transport_id integer,
    name character varying(32),
    name_url character varying(32)
);
 $   DROP TABLE public.transports_fuels;
       public         drovito    false    3            �            1259    18055    transports_fuels_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transports_fuels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.transports_fuels_id_seq;
       public       drovito    false    205    3            �           0    0    transports_fuels_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.transports_fuels_id_seq OWNED BY public.transports_fuels.id;
            public       drovito    false    206            �            1259    18057    transports_models    TABLE     �   CREATE TABLE public.transports_models (
    id integer NOT NULL,
    transport_id integer,
    brand_id integer,
    name character varying(32),
    name_url character varying(32)
);
 %   DROP TABLE public.transports_models;
       public         postgres    false    3            �           0    0    TABLE transports_models    ACL     8   GRANT ALL ON TABLE public.transports_models TO drovito;
            public       postgres    false    207            �            1259    18060    transports_transmissions    TABLE     �   CREATE TABLE public.transports_transmissions (
    id integer NOT NULL,
    transport_id integer,
    name character varying(32),
    name_url character varying(32)
);
 ,   DROP TABLE public.transports_transmissions;
       public         drovito    false    3            �            1259    18063    transports_volums    TABLE     u   CREATE TABLE public.transports_volums (
    id integer NOT NULL,
    transport_id integer,
    value numeric(2,1)
);
 %   DROP TABLE public.transports_volums;
       public         drovito    false    3            �            1259    18066    transports_wheels    TABLE     �   CREATE TABLE public.transports_wheels (
    id integer NOT NULL,
    transport_id integer,
    name character varying(32),
    name_url character varying(32)
);
 %   DROP TABLE public.transports_wheels;
       public         postgres    false    3            �           0    0    TABLE transports_wheels    ACL     8   GRANT ALL ON TABLE public.transports_wheels TO drovito;
            public       postgres    false    210            �            1259    18069    users    TABLE     ~  CREATE TABLE public.users (
    id integer NOT NULL,
    login character varying(64) NOT NULL,
    password character varying(32) NOT NULL,
    recovery_key character varying(32) NOT NULL,
    name character varying(64) NOT NULL,
    surname character varying(64),
    birthdate date,
    settlement_id smallint,
    email character varying(256),
    phone character varying(20)
);
    DROP TABLE public.users;
       public         postgres    false    3            �           0    0    TABLE users    ACL     ,   GRANT ALL ON TABLE public.users TO drovito;
            public       postgres    false    211            �            1259    18072    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public       postgres    false    211    3            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
            public       postgres    false    212            �           0    0    SEQUENCE users_id_seq    ACL     6   GRANT ALL ON SEQUENCE public.users_id_seq TO drovito;
            public       postgres    false    212            �
           2604    18074    ads id    DEFAULT     `   ALTER TABLE ONLY public.ads ALTER COLUMN id SET DEFAULT nextval('public.ads_id_seq'::regclass);
 5   ALTER TABLE public.ads ALTER COLUMN id DROP DEFAULT;
       public       drovito    false    197    196            �
           2604    18075    transports_fuels id    DEFAULT     z   ALTER TABLE ONLY public.transports_fuels ALTER COLUMN id SET DEFAULT nextval('public.transports_fuels_id_seq'::regclass);
 B   ALTER TABLE public.transports_fuels ALTER COLUMN id DROP DEFAULT;
       public       drovito    false    206    205            �
           2604    18076    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    212    211            �          0    18023    ads 
   TABLE DATA               �   COPY public.ads (id, user_id, settlements_id, model_id, body_id, drive_id, fuel_id, transmission_id, wheel, engin_volume, engin_power, year, price, mileage, description, documentation, repair, exchange) FROM stdin;
    public       drovito    false    196   �n       �          0    18031    locations_countries 
   TABLE DATA               A   COPY public.locations_countries (id, name, name_url) FROM stdin;
    public       postgres    false    198   (q       �          0    18034    locations_settlements 
   TABLE DATA               O   COPY public.locations_settlements (id, subject_id, name, name_url) FROM stdin;
    public       postgres    false    199   ]q       �          0    18037    locations_subjects 
   TABLE DATA               |   COPY public.locations_subjects (id, country_id, subject_number, name, name_general, name_url, name_rp, name_pp) FROM stdin;
    public       postgres    false    200   �t      �          0    18040 
   transports 
   TABLE DATA               8   COPY public.transports (id, name, name_url) FROM stdin;
    public       postgres    false    201   �~      �          0    18043    transports_bodies 
   TABLE DATA               M   COPY public.transports_bodies (id, transport_id, name, name_url) FROM stdin;
    public       postgres    false    202   �~      �          0    18046    transports_brands 
   TABLE DATA               M   COPY public.transports_brands (id, transport_id, name, name_url) FROM stdin;
    public       postgres    false    203   ~      �          0    18049    transports_drives 
   TABLE DATA               M   COPY public.transports_drives (id, transport_id, name, name_url) FROM stdin;
    public       postgres    false    204   ��      �          0    18052    transports_fuels 
   TABLE DATA               L   COPY public.transports_fuels (id, transport_id, name, name_url) FROM stdin;
    public       drovito    false    205   �      �          0    18057    transports_models 
   TABLE DATA               W   COPY public.transports_models (id, transport_id, brand_id, name, name_url) FROM stdin;
    public       postgres    false    207   k�      �          0    18060    transports_transmissions 
   TABLE DATA               T   COPY public.transports_transmissions (id, transport_id, name, name_url) FROM stdin;
    public       drovito    false    208   ��      �          0    18063    transports_volums 
   TABLE DATA               D   COPY public.transports_volums (id, transport_id, value) FROM stdin;
    public       drovito    false    209   �      �          0    18066    transports_wheels 
   TABLE DATA               M   COPY public.transports_wheels (id, transport_id, name, name_url) FROM stdin;
    public       postgres    false    210   ��      �          0    18069    users 
   TABLE DATA               y   COPY public.users (id, login, password, recovery_key, name, surname, birthdate, settlement_id, email, phone) FROM stdin;
    public       postgres    false    211   -�      �           0    0 
   ads_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('public.ads_id_seq', 7, true);
            public       drovito    false    197            �           0    0    transports_fuels_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.transports_fuels_id_seq', 5, true);
            public       drovito    false    206            �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 4, true);
            public       postgres    false    212            �
           2606    18078    ads ads_pkey 
   CONSTRAINT     J   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_pkey PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_pkey;
       public         drovito    false    196            �
           2606    18080 ,   locations_countries locations_countries_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.locations_countries
    ADD CONSTRAINT locations_countries_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.locations_countries DROP CONSTRAINT locations_countries_pkey;
       public         postgres    false    198            �
           2606    18082 0   locations_settlements locations_settlements_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.locations_settlements
    ADD CONSTRAINT locations_settlements_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.locations_settlements DROP CONSTRAINT locations_settlements_pkey;
       public         postgres    false    199            �
           2606    18084 *   locations_subjects locations_subjects_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.locations_subjects
    ADD CONSTRAINT locations_subjects_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.locations_subjects DROP CONSTRAINT locations_subjects_pkey;
       public         postgres    false    200            �
           2606    18086 (   transports_bodies transports_bodies_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.transports_bodies
    ADD CONSTRAINT transports_bodies_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.transports_bodies DROP CONSTRAINT transports_bodies_pkey;
       public         postgres    false    202            �
           2606    18088 (   transports_brands transports_brands_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.transports_brands
    ADD CONSTRAINT transports_brands_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.transports_brands DROP CONSTRAINT transports_brands_pkey;
       public         postgres    false    203            �
           2606    18090 (   transports_drives transports_drives_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.transports_drives
    ADD CONSTRAINT transports_drives_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.transports_drives DROP CONSTRAINT transports_drives_pkey;
       public         postgres    false    204            �
           2606    18092 &   transports_fuels transports_fuels_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.transports_fuels
    ADD CONSTRAINT transports_fuels_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.transports_fuels DROP CONSTRAINT transports_fuels_pkey;
       public         drovito    false    205            �
           2606    18094 (   transports_models transports_models_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.transports_models
    ADD CONSTRAINT transports_models_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.transports_models DROP CONSTRAINT transports_models_pkey;
       public         postgres    false    207            �
           2606    18096    transports transports_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.transports
    ADD CONSTRAINT transports_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.transports DROP CONSTRAINT transports_pkey;
       public         postgres    false    201            �
           2606    18098 6   transports_transmissions transports_transmissions_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.transports_transmissions
    ADD CONSTRAINT transports_transmissions_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.transports_transmissions DROP CONSTRAINT transports_transmissions_pkey;
       public         drovito    false    208            �
           2606    18100 (   transports_volums transports_volums_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.transports_volums
    ADD CONSTRAINT transports_volums_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.transports_volums DROP CONSTRAINT transports_volums_pkey;
       public         drovito    false    209            �
           2606    18102 (   transports_wheels transports_wheels_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.transports_wheels
    ADD CONSTRAINT transports_wheels_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.transports_wheels DROP CONSTRAINT transports_wheels_pkey;
       public         postgres    false    210            �
           2606    18104    users users_login_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_login_key;
       public         postgres    false    211            �
           2606    18106    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public         postgres    false    211            �
           2606    18107    ads ads_body_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_body_id_fkey FOREIGN KEY (body_id) REFERENCES public.transports_bodies(id);
 >   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_body_id_fkey;
       public       drovito    false    196    202    2790            �
           2606    18112    ads ads_drive_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_drive_id_fkey FOREIGN KEY (drive_id) REFERENCES public.transports_drives(id);
 ?   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_drive_id_fkey;
       public       drovito    false    196    2794    204            �
           2606    18117    ads ads_fuel_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_fuel_id_fkey FOREIGN KEY (fuel_id) REFERENCES public.transports_fuels(id);
 >   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_fuel_id_fkey;
       public       drovito    false    196    2796    205            �
           2606    18122    ads ads_model_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_model_id_fkey FOREIGN KEY (model_id) REFERENCES public.transports_models(id);
 ?   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_model_id_fkey;
       public       drovito    false    196    2798    207            �
           2606    18127    ads ads_settlements_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_settlements_id_fkey FOREIGN KEY (settlements_id) REFERENCES public.locations_settlements(id);
 E   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_settlements_id_fkey;
       public       drovito    false    196    2784    199            �
           2606    18132    ads ads_transmission_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_transmission_id_fkey FOREIGN KEY (transmission_id) REFERENCES public.transports_transmissions(id);
 F   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_transmission_id_fkey;
       public       drovito    false    2800    208    196            �
           2606    18137 ;   locations_settlements locations_settlements_subject_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations_settlements
    ADD CONSTRAINT locations_settlements_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.locations_subjects(id) ON DELETE CASCADE;
 e   ALTER TABLE ONLY public.locations_settlements DROP CONSTRAINT locations_settlements_subject_id_fkey;
       public       postgres    false    199    2786    200                        2606    18142 5   locations_subjects locations_subjects_country_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations_subjects
    ADD CONSTRAINT locations_subjects_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.locations_countries(id) ON DELETE CASCADE;
 _   ALTER TABLE ONLY public.locations_subjects DROP CONSTRAINT locations_subjects_country_id_fkey;
       public       postgres    false    198    2782    200                       2606    18147 5   transports_bodies transports_bodies_transport_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transports_bodies
    ADD CONSTRAINT transports_bodies_transport_id_fkey FOREIGN KEY (transport_id) REFERENCES public.transports(id);
 _   ALTER TABLE ONLY public.transports_bodies DROP CONSTRAINT transports_bodies_transport_id_fkey;
       public       postgres    false    201    2788    202                       2606    18152 5   transports_brands transports_brands_transport_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transports_brands
    ADD CONSTRAINT transports_brands_transport_id_fkey FOREIGN KEY (transport_id) REFERENCES public.transports(id);
 _   ALTER TABLE ONLY public.transports_brands DROP CONSTRAINT transports_brands_transport_id_fkey;
       public       postgres    false    201    2788    203                       2606    18157 5   transports_drives transports_drives_transport_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transports_drives
    ADD CONSTRAINT transports_drives_transport_id_fkey FOREIGN KEY (transport_id) REFERENCES public.transports(id);
 _   ALTER TABLE ONLY public.transports_drives DROP CONSTRAINT transports_drives_transport_id_fkey;
       public       postgres    false    204    201    2788                       2606    18162 3   transports_fuels transports_fuels_transport_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transports_fuels
    ADD CONSTRAINT transports_fuels_transport_id_fkey FOREIGN KEY (transport_id) REFERENCES public.transports(id);
 ]   ALTER TABLE ONLY public.transports_fuels DROP CONSTRAINT transports_fuels_transport_id_fkey;
       public       drovito    false    205    201    2788                       2606    18167 1   transports_models transports_models_brand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transports_models
    ADD CONSTRAINT transports_models_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.transports_brands(id);
 [   ALTER TABLE ONLY public.transports_models DROP CONSTRAINT transports_models_brand_id_fkey;
       public       postgres    false    207    203    2792                       2606    18172 5   transports_models transports_models_transport_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transports_models
    ADD CONSTRAINT transports_models_transport_id_fkey FOREIGN KEY (transport_id) REFERENCES public.transports(id);
 _   ALTER TABLE ONLY public.transports_models DROP CONSTRAINT transports_models_transport_id_fkey;
       public       postgres    false    201    207    2788                       2606    18177 C   transports_transmissions transports_transmissions_transport_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transports_transmissions
    ADD CONSTRAINT transports_transmissions_transport_id_fkey FOREIGN KEY (transport_id) REFERENCES public.transports(id);
 m   ALTER TABLE ONLY public.transports_transmissions DROP CONSTRAINT transports_transmissions_transport_id_fkey;
       public       drovito    false    208    201    2788                       2606    18182 5   transports_volums transports_volums_transport_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transports_volums
    ADD CONSTRAINT transports_volums_transport_id_fkey FOREIGN KEY (transport_id) REFERENCES public.transports(id);
 _   ALTER TABLE ONLY public.transports_volums DROP CONSTRAINT transports_volums_transport_id_fkey;
       public       drovito    false    209    201    2788            	           2606    18187 5   transports_wheels transports_wheels_transport_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transports_wheels
    ADD CONSTRAINT transports_wheels_transport_id_fkey FOREIGN KEY (transport_id) REFERENCES public.transports(id);
 _   ALTER TABLE ONLY public.transports_wheels DROP CONSTRAINT transports_wheels_transport_id_fkey;
       public       postgres    false    210    201    2788            
           2606    18195    users users_settlement_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_settlement_id_fkey FOREIGN KEY (settlement_id) REFERENCES public.locations_settlements(id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.users DROP CONSTRAINT users_settlement_id_fkey;
       public       postgres    false    211    199    2784            �   t  x�]TQn�@�^�b@�m��|�=�I>�~D9 �&D"��R��Vm�^`c0156RN0{��7k��Z0��̛7of���+�_��f&��Ԥq�G��cǽ8��M�c?�V��dg�|��$ɰg��R�k+���D?�m�ʞ!~⯱��1�w��ZJ�r�V*��[��N*i�Y)��AC�๳p-���yk�,� ��%�B�5�T�����V*ͬ�`9K�0[�� �'�>[��YI'܂��)Qѽ_���|��׳y�\#�)��U��V�%��*�	�� ��3��(�s��A�=LRZk�-7Z-2�P�/��h��B|��ժ��;�g 
�#8Ei�S ���`K����d���U�p�D�0�� D���ʵ@��?�Ze#k�
��"�@o������.G�w��H&i�l
<�be�Z�씋�'K�l�W���)'g���d`I��ih��������BI[t�$~��w�6�J�Q�p��B�* :�_�a�A�l�H�������~�3
jt=ܿy�\qEǸ��1���M�7�Ҥ'&��7?���<�)Y����ߌ>�O4d� 1��w����rD����37�g�g��xv@WѨE�_P�$      �   %   x�3��pa��Ƌ�v\��,�/.άL����� �yk      �      x���ے�F�6zM=�^�+�3�8�	��$�o�J��س���e��e���u1�֡�v���
�W�O�3��*ح��_X�J��̬<�7�����ß�烼*v������������}t���f��՝@�����C�������puxq8��=��p~8��|Zo���Y���w"���.�?:�]H ۺ�`V��;1�}��.�}ޔKzG�K�^߿~t�P6o��*�g�+�G����U�^d�}�������o����x�G������j�����n�����i�-��'CF�������l0��r�̇����)�xW�s��}�ϸ��y���<��K����S��g��i/����C(�G`?��EQ.k��=��l_Ѿ.+'z(�z[��&���?�Ey:���w<`���״�Ǉ?�v?[��;�����|/�q�W��	����ekL�u9.ik�$'�輰_�ۊ�=何w|�)S�wyx�'�V�r�����q�?����|��x}�\��'&Љ���@���LQ׏��Ș���H;%�a�ޥ�|CdKh�7�jY�z_4��X�r�t��?X�U�8�?I�ĉ�h�J�U���>�姴��t��	ӧ�������29�%J9�e��R�,X0R>�h xR �r4���O�\l�;�/��_�����U�l�<�{U`�ML��N�^��;�� P��z�T�� ��>�~p��O�����7�?���n�i�;�����	b��O��?��=����} Dń*�B-*�k"� UqBO���|!�&����D>u�Y��$YHo3pUAO��#Y�b�[�h�z�WD*wBOX�
�4�Y����}#>.�da�91T�Η�SH�����A,�P�te	k^3]�	#C*���H�#��˱�O�dO��K�M�V��v����oן��1���{K���خ?%fnv��L�������n�����e�8^���rOĥ����� �W�Ӽ�g�|������Bo(�n���ߘ��#����b�g�Fh������\$tJM���D*��7�����=S�E^$��J_����(��]AG�����IB�t��NJPV���G>qn�m��/�ǿ�d��MS�Lx�=���ط<�)Ƹ�b��Z�(-uƁ>f!�ן��E�?�~t�Е��^�vC�ڕ툰m\@�X�EM�G�b�/���M����@^��O�/�����0-ĩ�9^��^މ3���?��߇���l�n�qt��q�9}�I�HN&�\��P�6��6����,�n��m����:��5���.tQ�h�	�� �H(
�p��C	��U�����]K��f��C��LGԧ�vjh%6�x'��Xµ���J�$���&w2�2?���ӻ�g��`n�^��ftc�g�y�ˇ����|y'�)���z�.9@�4��K�#ӑ���&az}(}B���bM��r�zVT��#��@��	=��O"aՂ��@�������j����IC+���#��k��˥]1���DF�z��&=e�����N����K�{�p Hn�oZ�Th��Xd�[7�zC����V]�xWG'M3����,z�f�ZY6�g�j�饬؊V�y�����Q��j|��)]���,�?� �Ch����w�򳐡~�j����B�m=�'��f�@�;רQ�sܡ�
����$���ֳ��,a�gx�K����������M�^�ɀ���W��g�ȧ�|��g�l�TOyk]0�1gy#��(;ϡ7�f]���t(fjV�G����dAKp捀�Ϙt 8NyCdO��]�����P��s�+���8�)z�pр��mN�區П���2y���E�?J�Y&1Jo�O0���MM<�6�����a�t:�j��>��"��d@7ٳ%�d�jk��$�������(x�b��������%l���rA��I_����Gs׵gX�������$%�~
*Dy ��Z��Az�0	��3d$8��m�7�� \-����`���A�TZ����d������.��A'���י�0��V�;�����I:HH��uSL�1}�T�{��.��~h-%�������=��./U��П�%�T�����Y4��d�,����%��L����X݀b����W�g�۱?z�� �H���l3�ĺe�rH&{~�q�+�#&?5+oA�/�l^���U(��Й6P=��  ���d���XzZ�5�X�����Q�f�^N6�u�����VP��N�;ي� {.�c��Շ���-D�Kh��}BFK3�W5a���@L��l��8��n؂]��#6���������w�?ؑ�E�/�d�b�SwQ�Е�#����_�Ta���5�w�Uu�$��Լ�X�4��ygYL�ϊ4|%_�$NEޘ#ڒt%v��������#w�-�3!����s ܻ�lA��Ԑ!p�L��SV�+�IY��U����<��y�b����sa�e�?�k)�$�j+W����H�a%j�h;�E� ,���n�o��!�ť�'�`A�(�;������_���5�1��y�w�8�� �Y�Eu.Vz3�/ �5z� ]YGͪ%(��xQ"~�Q�x�r������)��(�Z̎�����eD[��p#��D��a w;���1>�	��=e=��#Ig ��E������[N:�
n��y��m�ô�yS��!Q.Ix���8PV.�mH���;>���`�j�D`�Ҳb���g�ԋqlt�ZC�h���b�k⹽ ��0�g��d-\O�㤞�5��.����e��$ɔ;��HП�Gɮa��҅M_<m���ɨ������e��^"��=��dU�@I|�c���dP��c	��3��%��X�%��F���Ր'������쭳�Y]-���'���Q��"!B�,�!��}�ǝ�V.]..�g>�D$d����ɮ�&�+�;
�>��Ք�כ&�bE� >^�[	��6�X8[!�����uq�<����� $���N��ÁN&WO$�U�˼)��H� ��^�'�6߀��q^�MK�W�p�0���s`�-������K��퉼����������a�?��%z1�K2�B����)���3�d��մ&kp�*�j�F��3q-Y�yو��X�8���ԠlP1���8˝b�"4����Xu˻)����nO�*��Yw��V����!10��ױ(9qD?}T=�U�g8�� �e�E��#~�}	N�+\�-�X�U�3{J�r�w�r^W�OԳ9��#ކrN����,;Fџ����2}��44�f��F|d
/���?�1���=��,�\vs^�;<��| u�O�?�E�1��1�����Xm�W�˞� Ҽe��T���H=��L��?:�Jj��/[��(����ꁾK8Q-���������1u�Țbo�p��J�=z��{����a�"������jYG�$�:,�pb�$�9ʾ7T����'�6_���96�c���=QF��(�����@�kU��d�/��V���H>Ӎܷ�m�M��1�p:�3@>"��tkI��'�1�G,��^	��J[��V*MTb��p�6ɫ��)�&>Y�xG��N�lحE/|�Z���b-�lGZ�R���b.�&߱�X��F���Ƞ�v</y��o�GLmlS�Dg�����������,���X7� ��<��V����Ȩ�#r���z�^e�&߷�>�g����C��W�]�O���7�D�|_�(r�\ k�W5� Ff7����y��nO֡)���x��� (���gGG0���kc��]m~ ��~���v�ZA$�uJ��
�j��nRTBZ0���N���S��囥��	hfo!yPn	��G`���:��}.PE tYk%e��2y�Ӈ6���Y5��n���B��zػ��*6z�!���/����z��I4v>k?�1�$撳��Mf���¸PM��V��X���P {${    3.�kC/��d9�=.f������">R��zI2��Da�/���H	O�C1!�	�$L�1�'�5�u%g6�������/:oU%�y�������|
�IU�E��z@��E$�G�Qh��Oz]��&�$���q�
oG��
;��5K�K�������K}�C�Z�ֶt	1H"\vn1��(�xyJډ2p��f�J�'Q&�ug��#��?�@�bthD�ə�͘���mġϪ����~�1�Y���������\r|{��p�d0�p���j�9���lU�>Qli5�UQ%���%i�5�5���I�kc1��� �/�Co�}�eGp�wc�Ae�����Y-�����Xŝ1�����Y�h�Shh�T�WL��8��z � !_�,��L��� ���gㅛ���@��M���.�~	��F�W��|Y�a%� ^j���|[��L��o�	��`��E�y,f�DV�)��T�&&��IZ�Q����a��q���ƤD�H�^��
�$��{*<"����M>!�̇�X�H��/�)��5�z�v7��%�4�|ԋ���@M#!��?��?�6���":��z�|��l��+XNU;�b3Ti�:�	V�L�Y��ݑ`r�F�Z#�e�s���x<��D�:�I+z{�!Ǉ��C=Ƽڴ3�c(m#u�h{���B����uI8?�۩e��"Y�]��oR���B����|�*s�̉�M�D�]�0#�}��b*Ԣ჻�kR.%�#�x&~�	l�<���9*|)�c3��Fw0�D���%�>�-���u`�K#cxe�"0�&5n���3����7�ր�g�J4�Y��%E/��;�0`�GJ0rP��!�4�$��+xX�+��aR��SO�kB7���g��?��j"1$�Iu�7x�7�3�K�8h�nc�e{�K�t��_�A�9m ��}�j��t>������?~EL�!�K�$��z8�5d��+�Y=� @/.B _[��Jg���"�P�(����K=�9��KZM�+�&>4�4(13��&�=��d���ENf�e
cF6�	N#� d�$��}��۲�X���x�KYf~e�y�����h|_��:�1��zC$�� ��j��n�m*���T,��+��7>P����@բ��=x��%�5X�M��?��@$��'���?Je��	r4�z�c�0�{�T�bJ^�L��@ڏp��׺����ǉJ��8Q����G�@K8q�Nj(A`� R��OrNc��iŋ}�F��)�-�_P�� ����%��%I �B=:�y��N�E�nr<�p7��6R�|������LXPBT/{Qv�i�"�o�V�C=?�^�9�,�AvO�\E2���m~��^�N�D���l8���Ùc>p�(N���wH�7�}��	��X)��EJ��	��x%4�o����#�O{Doc ~�'�����E��-A>�z�3,��|�Ǆ�ߖ��P��l'��|�%Q�2lR�׋�"q�N��$�@^�$ Q���T)��X�^R� ��� $�% �%5٪$Ć�Rq�]^?�Uh��>��-A'�-� ����&#�VSY�2^�*��MQ1�ó�.c�,�����@�\MtVSQ+NZχ�+���?C�r'� c��(�\��,W4���qO���͡�q(P&��{�M�ɗKß1��+)��!�WU���q,P&u��]�I��vșA��(�>qQ�9=eM��k����8���_�M)Ҵ�TSa�g��wQ�%M�ٵ+A[���E�$rL��r �_9"Np _��f�H���M�;��d,:��D%0"D%�u�:���q^��HЇ�Qh���%�gS��7Hp�C��{(ش
��p�+y]�'�k� �_"3�>B?�v���LO�Z.l^�EҦ�2'u:E�פv�R�l�U�?B��wC��9�^��OD�s�|B��Ry�0x��)�P���*��$C̦���)R2N��S�K1�u5i�r��M�����~<�{�C_ijX��~��j�o��*��u���>]|��e+��Fٌ��'��pC�X��`p,?@sa��i��{8�#�I�ex�.?���pL�4�i髆$A���@Fr�D=dٓ��p:jM���؞Ҽ� K�N�"b�M�潭���#�dYb{��.lv��z�0�c8����Ů��plֽ�Mj=F��M� c�\r
��bnY�r���BX�{|hy��f��p$��$��r�	"XEV=T7֧���Ґ�\W�\�	������4Hzߚ0��?���L8�� $���-�֭t�� �B
�s(����̐�����!�@��
�|�D}y�TI�PH�c�% #��& #C�@<ف�f��=ǿ�m��D��z�k���S�u�|�D����pL��l7N1�ݒ�����S,H��@���H֑I���eSV�c���;�*"�:b��G�b&M#�Y[�#�?�g��'q�!�bSo�a>�h���&`dϞ��5Q�p�#fO����*.%O}������1��Y�;H?�����Ȑ�ku�lkb�)?+�%��tq�����٤6Z���i��"CBC6U��L*��L��D�y9n�Ok��`�JbE�L�c���*��*�)�/��?@�F 5O%m�s~�k����n"P�Db��H��r�[�Y������F��G��R�G��������ν���(�S�N&�*�����l�s����8���G�ܵ$��K�e⌷ȇ^���C���	K�wk�Tm,t��BD	�MH�)=������˵&�!΀����+Rĸ@��bH��&�0��xdw�[8 1ʻ�N��������#,���� b � ���6�z�nߐ+�F��,�Ȣ��.�Dj�Qɴk�Z��3�l#����\D �ӊ��6�%m#ɱ��7#z�nڦ�|萫�F���&-�Xx�ס֒����nԨ=T1�u�B4�Ίm��+ܑ �{��2wJ2c���F*c�z ��j��K!T"A���!A �Ţ�Zl_���C |�ɀ%	�Hp,�˫C����rRK�Zv?����ߒ5 �ɱ��K<ĺ�:�MS��Σ�G���+��j����� �'K�;l�ʡ8ġ=�K�]oM���k.7���c��k�HJ���b�T'p�G�h�߂8��O����5� �A��moF���&���5��⊄tq��V�p�uuC�M
�e�:T�����R��*���ĳll�z�>�0�u��=?������:՞��R�+M�9u��	W�PŃ�6���!��V"��$�qW�f��N�L�@�HdaE'r�*�\_݌�E9��])'}G%��!�$��u3�K�n��Y�ŬS����ܜ�x���D��J�b� *қ���7���8�s[4P0,R�;Q��=�O�5�������������ö��5�R�*9��Cϼ�=�gz���=m=�M�\�d�>��(~Ņ�fM��-W?�!���B�¶SNʃ�����9��6��ǈ��� �k\�q~L�]\��,t�f��-'�wȖ,R�9!��^�ߢ$AO���,6t�Jh�X<'�mDY��f��DɁ�5���~����(�O��Y��eʍpߘ�#ann�1G�[4���)��B""�I�e��z���F����k�G��|�hd���-�O�_���K-!�h��Cq�*�����.�E��_�`W�hܝ��8�m���*��TFI_]r� ���
!�*ݮ$���	��(�\�>62يZ.�Y�����*����g�h������WYL֨C�d��@/6s�t��Ly-T��{a3W�Ţ�0q�E�%���mg/�Y����x�'z��6ȩ�(גy�*�Ɖ.�\E���V	��O�?�>=m�Ŏ�\"�_rM܉|`�Jz,��I�c;�ӻ�.�o�pޙ#��r������o�!�����C�pE���#�g�{�d�4� ��WB��z\r9&���:������C�gsS    ���)a��t<�����4�,;`�����M d���Xs�� Rz�|�V0;1�j�6��b�)4�Wb�,��!��V+��>�O�VI~N��j�pD�m}e�P�w��G<2��f+ڲ�L/6�������/�)k�ԇ>�5H���'X��QBr��GJ�EN�n��x̣^
c�/ZQҢ Rȇ��͞�ՆӮK��XQ�NRK�(�5ya�����k)��������3�0�p���Z%�K�#�̸�qC�@6��8�)�|������%��[��=g������^���s-��݊/����c��2�=�����$E��T4H]u����0�Pe��T���?	ج�C��n��.��jjlaAh}&�o�� ����$V���%^FZ`�
>?sb�h4�3�E#Ex��6�,��FD+���j�[��ov}���8��b/���Ո�$)LQ$x7]���FF�Z��"���$p2K�"�J��V�>GP�<�o{*O����DQ���!�hL�-	 U��e$�H��q�oް�31�(��������`g����c9$�b����� n�-�#��� ��L�P��rLO�I� �ZZ�$[�@yqA�ȇG�󶩛Ͱ�E�D�>v��9I�82�Ҥ�Wb��<"����! �w�3��DiMzg�� 颡A�(Nu�4��f����hq���L���у˵��H	ǪV`�Z3(XM��0���(o8�?�YN[~�`�{��?�	)���C��*	:�F0�W�I_��Zأ�c݊i�S���x�����[oL�伫ؠb��H������>Ǘ�ݞ.�[���LϢ7��xD8]^]��@��L����T��I]�.`+�v�/�Yq��H�+)��B��WM������6��R=x�P҄K`�ι�	�@*���r�/A�D1/����?X�9tN�]>����F�t�C���!NI�hg|�O#�o�O�˘+#\���B*��!�ƪx��"�+�	�u���%��smJ�$�(w*�����@?Ad��o�?���RU��@o"�䇬�B��P̑W�Y�4y_5��(8oe1�_���M��?m��kF�>]ȳ����{��C��|H�?tt���Tۏ��=�̖5K�ݝx$��CY�ڴ+һ��ՇC0�#�u�^?���V%�V����p��@�/:V��K�{h�I��Ԉ\׫9�F�e,��UtkT>���f#1������=��Ĩ��wN�#�r�+Iq�G�2����<'�ӧ���^Y�=�C��MD�eI��mȦ�{#�V=9�I��	Z����A[:�W�X���H&<�&*W�B��φ'���4��,Ē8�E־�:�Ew�7�	Xa۰ ��u>�_���!1���~I��E	 ����b���Ne~e��R�/nl�����9P��'��@�);�6:S;`��θ���Ј��T�Vןs/��X�}��i%a��V�?P �׃3���/��Ν&�O�(��	ud&�bS ��Vo��@��{m#%ޱ/h�� >El��Rp�O�8����LPx�$���Lq0���9������$U`R�g���\�\�W� \��z��vy��^
�KX&}�X���=+��~�J��V��!n��f=8��!�浛^ �g��u��S�S��?�j�A��7'�/i��!g������h���Qq ���+�v�CC��.�MG��ٳ�n�)�~a�[�+�m�s��a���P�<hu�#nr��*�P��=����pg��Xnd)V��=U���1n�CN'��ʶl�q:�#��LV6�v�v�V����T�X��Nx�pl��(�BS
)�����B�������ү�-�Pԅ7j@�I:���~�6�B����1v	$T)$~`�j�aX�lͅ��Wx�s��N�rL�d.��a�e[δ%f�-d�M�eo��V1`�=�K�ޘ_�&f�H��52��,YDF��oU#T�B)H�Xpk��گS�pG���Xp͵��k���gǾ��0��z[��@�8��UW�O&�Dj��X��l��k���bCk�ݟL�eR9*2��86�#��~kgt|\�U�+���7�>ձ	�� �C"KZ�l��6�]�"�=����)��8��N�R�$	ń�Oqn-�o�i���
��Y||�`�[�\<T�v�a$���߹�֞��T"��1��E1el&��yi�h���	/n�8�]�;��`ș��I�/���=�q�*a��U�쬜J�E�d�y$���F���W��>ئeZI�O�f��%��d�V	*�̮�M_50rW5^�Pz�c�Bђ�f�������k��gʺ�i�M1P	��� ��V��4R�;�{q�VZ;��؊��I';��+9�؟[R*ǧ��/M8s��Pl���^��T�O8�p�N�%���#�a��KvޙuFs���dw4w��͞�؊�:)�wA�)�D��&�V� ��W��4q����3��DO����
��)�Iq���p�r-�8�4Q�2��ۏ��L��3A�x�^ʥ�!�`���7��N2T���O�Jn"	L&#Ow˕D��;k������K��K�(�da�V�-T�z��6--Լ9"�J��saY�^wqa�Sg�uU��r��f2Jt����jY@��q6�y��Ι��ˎ��B2���&Nz'�F�] 9H�P�d^�?�<8�>�����<|�K����b/1؆0���M����Q����gب��p�W�E*yN5��(7[�L<A�O����vɬ�CXH!2i�$1�P�}M�qY7o6�B�X��5�ye�v0o�U�g+p���㕪u&M��R�� ���I��EA�X�Ra�l�a?�{����?��9Si���GF0��[��ћm-$F�lHN�{��>�����3��^h-3�������<��l]��i֟6�暯%C�)�
���՛g��e�Y�a�-q2�1t�sqİ������Wp��r����Œ��& �9G�Y#O�N��������yŹ�l�	�	r�I��U�ۍ~{�M'Op�s禜�m5[�FDɡ�$�{��U��
!Z����A�g󀓩�JA�g7�r�N�0���d��%Ȝ��
j���R8ҳ�bo�ucU�k��HB{�֠H�-��@'�q��}��I�l�}�y����M�H/�HF���ö���x�jdv>=�ۼm�/O 1 L��\6I1���ER�-�X�)���=]��,��yÌ���� 2 �&�!]��ճX�I�ЊT�����$X�l�t��	^��ؠQ3{!�fF�eK�����;Z��ΫN�D�>��^~׼X�[��j��%�3�rB2��H���,���/Ờ�m�O�S$����du⢣}r�\uQr|��?�S-�|�F��#��D���w��tc�O$e��m��|�BIb��7�R��Q�+���b�l�V���t����cA�Zf6�Ҳ$�?����79@B�B7[��;l�f�qd�]���wbnQ,���^K��$�-C\h�~�X��#D�[WS�IW�����4�y�=)��LW�ؘc���8I����C���菞%*��8"ٖ�������l�	*�$�~�3͜����?-xhނ�B7�	�]p{�ݳ)���-���<4�y_�6�ȟ/ZN�L�F�����ąVt(qO�TOFZ��8�OdRO�y���S�������
��i�эo�*If��ȗj��J>.:$��X��M}�����EM����
Z�D����YD����]�7+4���{~Kd(Fݍ�հ/+I�#�wt�VH�O!��ͫ���9_�i��L�,��#�|����x������p���D3�������N.g@3'Z��30n������Viوg���X�)0��Xn �:I1�ܰ��7�$�1�4�I&�O�O��F}����"�vMc���/T�C��#i<�]�brSpu��I�y�-�Ȝ�;���9Ͽ*��*Lش�!/�ӨV��a�sܔ�T��l��&&ΰG���R���E4�W�ESR=�"����n�)����X`��)�    ��!���M��Ɋ��ѩB��#A��n�*�̈́#Ӱv��'e[1���ژi#RC	 �~��:f���0�&����t�����P[܆������;�{��f�H ��gzhn����L��S�W0�d���00�<��3����	]5�Vܠ�Z�[U�	�m�v�fD��Z���!uB��r��Kգ�*=z�.I����u���)A�� )�K'�*�	y��r��m�le�>��`���|�}��+��2�8P�����״-X��]�Zԇԗ��4�^:����R(9+�a�1�}�������'i$�.'t��ZY��Hm�sa:?�̞�K���5~����!eK�ic���!���I�VL:�ͣk3�}5�Z`|���T�܅X�
w� #���a֕S��꾁v�½�O�6���vգ�X�[����3c��Cˉ._Ika�c�C�v�jd��{��7	�U����4o�������i�0���ԅ�:3�S�_���ë<
��P2�q�5}�ũZ�<��UZ	����,��u%XC���`ҙzJCA䏚�������nK�Xa�1u��uL�^��ᤐ��4��Nj�4����[N���O�b�f�n��FW.�j(��'L>�];�hu��7ƿb��_ފ����> � '�ov�]���=r�m��$�'��"����ɚ�R]V���lw&�%��ҳ�z���z����	��v������`�T=��ܣ5��z�F�}�KIhi�KBc�Z~�֒�s0�PB�F��5A���-�G���:�FT���4�T���e�0Z�X���k���$�ƪ�����B�TE���F��R��1�U\ߐƊG\A�;��Ho�4��A��p�&�=e�d_��rIw�F�����5G'_�����C���=��f/m{�D0�+��ˡ��f���E��c�������Z�����֙_J�rXmy�DEO��k��{�O$�+-�>�6�M��sg���`��3-ecSМ��)�RN�mKۤ�ķ�dO:6/S���7Ç�}'��r�+��ܝ����O�AD�K/�-b]P�b��D�Kva�X�S�0��`��yTgg�l,��?��祯�_5- W|�`�Lʦcz4��A��~*�\N�{-��䚳��T��8�LP��Mɉ�%&�	n�uU���!����>�`��0-�hSA쿮jԭ�y?���h4_�pn[c�[}�5��h�lRfn�ڮ����VP)[��DU��ipU��fB�a[2s��D�.�	.�	�_h7�V������|c2}S6)3I���H�c�oz��uC��V:�d�Y�)�ّQh ơF x2$�S���oq��V�2T(k:!F{n�0�> �E�)[��8�ީu �{�m�� ��_����@d��G�G���hM��`	�X6P��3�����9�=�?�����崌#y��m������@�$����R�%m��m���l$w�����{�2�#�	a&r6
o�ŷ&i�(�Ŝs'�rl�����g����f=�|_В��?�7�Cv��T��~9\�r���~�!*�ډ:���D��
����g/8�䘞 ��5������q����eOp�C��gN��3�W*>=��=��������� ��R�I3�f�9�Gʂ��<'�p��Y|����ߝ�0�A>)��p��+���$�P0�2���Jnl;iM/�̓��\�5������5q]� ��Nq���M�9-�Y�ĖO�W�GH�.iS����v]��thOx�9֗��]�
­����+<F��a?��S��j��^;ޕ(H_vj�����l w���j]�����Ń9���7�%���F嘈xd|�O;���<Jx�8)���x��H�qo��)�L�V����C��>ʕ���v��}���ɠ���t�<�c�@���GfN��;�ݵj�y���&����G]�&c�b!�z�}Cmt�̚�j�������j���Y��v�9(WCm�byd(J=\�i�E?K��i�NRFR"|
�����ĉ6�b'wŮ�,����.:�[�\sbF�*�U�7���:��W ����9�]�Т��&�-�B9��%��f:��r�T�,���a�aǊRG��n��[Y(x�QR΂!7/�sCA>R=p(�|Ǉ&��:0}Ki��Ok�;a�Rp�C���̡25T�,�aAR֔E]���4$�i2�E��?l_ .��3�$N�T�qnu�,
�����ܕk�7�<K����FFǞe���7u�I���E��ӘE�n���N>[��n�Іg`jnP	��=�OI
B�,#����B9�4Kn'K��C�~���U�W�T[��+����=`�c[x���P����W����Ł�7�A	UD=:Ȱ*n.��`�.'�qΟGJ^�G��h�ñ�,6�{�B���-Qf,�E��C�Ɛ@,h��2�4�B$(��amE�g�9��X���5���N��z��������7�|�9QD�OՈ/�*��$0�q�"7]��$t���^���{$�d��;����2�B����sj]�V�iB�%�������ynE��/��b�WՊ�~�{&�r�����
a��:R���G�b���,oB�b�����v��)g��&����Ax�ݩ�|}_"�L�T��uڅ���4P��4�O�b'�8J�T�3����Ig%�cZ�)���y��vZE������%zʏ�X�`ݮE%�����2�=����\-�Z�83�X���3�^�
��{�����2��Vz�e<5�C��f���&��?�=扰O�~��7_#�@���H��x���3�.�B ���Dͱ}�A�
���$��gB�{~Z�?
/��2I\�ر:Ƀ�=�@\R�m���,���q�_K�f%*D&x�^3��8Ţ�,u��Hpi<���aNk${���<�s4���X�L�d���)�h�Rds���H���|��y;h���]�����6;�5���o��Z�iJf_�\��L+��H�"㟨<����\ɎF��޿��!POP��n]A�lw�w�6� ��&����>��x7��5ID¡|lF	�r��K�S1�L�~yI��M����
:����O@���3tb�)�#/6�B?���)�|�6���5I&��YE*.��Ѐ�_:ݓyW,��L���g:U�ۥ ���e��S\�jCΪ�#G랮w�
�Z��5'έ��% Lˁ.�h�%ێ��ڹ�dÑ�AK����d,]�!#�Aut���M���F�0~�������*o�S�Ţtq.*�2��3���J�ed�7
F��3gH٪��d��)A�����;�-A@�}�%���%�㥕@W$��j��y�L6�l�|q"n?����'�"�u�ƞX���i%VDs�}I�ls#�)��]�W����"u5��gA�:ЭB
O�Nl����^.�Nhٳ�7�w�9�6���c(�B�(����	C�t�lK�y>���0�[�Ƙ#+�~^s�q��Ac�I��6��Cbt[�����ߴ�?�w���y��>����CY^-�$[m�3����E_qk���/E��{v�s �W�vQ��y/P�9mJ�t��lI��1��=gC�!"q��&If�i�L6�LM�Af!�h
ַh9����ƚo��L��7���}���7Ā/{D�J��~����X2�h�`QT��;�iu���%�W�fβ �{�8�P[-}U/�����0$�����e΄sb�,��Ȁ]K��
��v�!hT��Lܒ�5Мy�f�s_vߩ�9C"�n^n�1�:�OZ���֥��g&��H���Tb�Ϳ�؞u��Ժ�-�ڽQ22hT/�q��ɵ�U����/CJw$��O�,\�󴨛i�h��3�c^��Z�ls%�D�k��=��ϋ� ���M�Zl�0"�k��0ͽb�,g�h�o��Y��J��FZ w����5��d#�����>��	KIOp�s�Gl�uU֒�+�OU�9sa�F�A{���.	�Z.<����$�&�|�fT�����C�*�������&����L3�QX;��m�=F��WH�H    3�%Z�uܮ��27�c�X�{��������+,8#�u��(Mu�Fa�Ċ=A�B	No-땈l&��R�h��"�M�j^lU]��_)��u&H��4˵�5�^s�fA�3~O����	�en�k���h�E�D�=���)����2��,qɨ�S��X�L}�T�F�g"���k�"����eJ������̪ԗ2e�脦�b
�&L{���"+^<?�Iͮ��gs��k�r�k�5��S���>B8<l���p~���s����N��%��0v�n S�y9�oz}�JiTG�J����qI�v�R���wȽre ��<@t�C���Ѧ��w�o��p�i|�\W�G�獎$ѿ5��G�r��BLK.�����rM��s�օ��''����ȹ�MA�����H���~.�oȖO��H�pz����5ŽM���N�z^�
�Y�
�N�X�k��]�M�,�������x�~�����s�^��X�GrtG���p��S<�)�(.]!��ԖJv�{J����<P�ׅ.���a�_��j��a�����t��sA�m( I9���&�O��P2��#r�nK���
��H�� I��q��{/Y�p=�	3�]�c<a�#9�[�^�3�Ss�!��7�.9Ca�Y���d��h�U��wvxqD���-�J��ex�����"�m�p�l3���ыS��
���*SO��- �S�C�rX���9��bF&�j�zAh�Y<������j��+t�m�2��|FA�4ߍl������.Z�XO����:�e|�P��LaC�A������d��&����¸h���Y>���;ѩ�G���M��*"�!g��X�x��H`I+�j(����Wz��ϫ�r�)C���E��+i�P�����m�v���ki/�i�Z�"��qr���@܎�FC�)հܷ���0p�te
M:!�߼�<r��ىކWp��Y]-,���.U��*4R�,Hf��-1 ��FSl�P�t��S�d"��}�i�f�z��)� ��V�tv���<Dx]�xM�ݰ�禸h�Yc�j�VN���ݠ�]���D��(/l�F^p�F��1�}3:ٺ�yr2@S�ˠҲ��zUXA��qQW�)�T­8xR�|��F�A|{�<���yd,x�r��y1����c�����`+��6l����6�W�ش����p��2�4#B���ޤ�p*ϐ��$�3��]b.���Nc(v��[;\}*%���Ež./>��]���w�"ǆNS76\6��N�:�s���=���q�[�S�gj	�����K���0Ή��{g��E���+���g|>ⓞ��_��`~^��2���Ϳ�ƹ�=T�C~����Gcz���^�id�ރ��$f,/���ण�Ę�/��d��)ٗ���Se6��������z�R�M��w1F(��^��G��w��왱?����:5��i=������rSn������r!��p����כv���X'������d�B��kGKI���n�=V�p�Î�Գ ���j�W ,Sr�mnŌ:�=Hz�3 �^9�c���AO��L��z�s-嵒k��F+|�3A�,?� �g�Zؗ#sW�f�ܕP�!�^N ������������yr%}�Vuq�0���Y_�6l�U7lT���h4r����~�e�]�4:/�5^�t��uL�N��\�{�c��A���62�3�B�u�4u[WH�"#mt���j_���������ܤ��'dW�c ����_�j���v��}j��:b�G�a�����Eh�7�E�>�����͝k�wv���N��X�S������ysbn)	8��*��<:��#��,��iҝե��%y���܌�bݜ3y��]����mnU2k�p�]������Օ"���2ov���k�fO'�I7=�6�W�}5����͛bY:ġn�o�|�s��շ"]�^i0���܎�t@%�صqn��8D���]�x���a\XF�����3��n�����f�b�T�����z2��~\:��n��n�!%]�,x�"������i� 柚��=%Z��:Y��@�����B:;�{�h�7�Nkgc��o}y�J�<h����߉L�s��+In�U�Z��c�;�;���l��]�o,"iWt�����|R.J�(���p���}�`[�E�������*
�����>�T��Υ��,_T��}Rp�v;n�'\�X�~ѿ�߽W��G�(W_<�w~;��k6��dˋ�(PNa��FIa�}pj�'�Ů��t���du36��+p��JY~Z��z�w���Ȳ�e3Gl�ۼ��K�:rw�V�Tv%H�[h3%ה
X&l02���$[W�O/UL�ӱ����1����s��B'��#}i=�@��t��s�\EpYb���Qrdv�̍���!��G2����D:]Tf�w��'��������|4�Ph���v�0�ܡ�`tg�u##o��=��.gdM����?�f~ԛbo�*ڵ���ѱ�{�O�3���2A5�5��o�
�c�n̥��#SU�V��P�v��0�鑣j]t�*_=E�95%@ݾ{�:��
�5��������D�C��J�~޷���0T���T�!@�оT�O:l����M�v�n�K�F�-0�Su�73s�����e��OL:�����)����(��A|}��X%�U4����zj�RC�;ᤳ1/M�Rτr�$1����w��fL���R���9"�Ga�Pg�b��W����7�i�}y�ҫ���5��f�81r�y8�I�A�O������n	K$�9׊��,���J���_�Cݐ�s3�(��7���L� �hI}@Opr�^:Y�-ܽ/5�<�/�p�4�b�e	m���x[(� n$�O;��塯UN�G�]�=RtC6oѝ�Ț�sB6ɒ�����K�O��{d3C�d�����k)c~�d��rH��~6!����z���sp�^�}�W}B��JGen�A}B�tv����S	2������2�8��W'�� ��71+V�Wl���6��`�1�Վ� ��G��I@Q���� S�F�AD�I�vL��!�4R�9������ �:ٶ21�T��F��$i�VhV�=^��<߰�zR�k������[�������7]���%eD�I����߰$!`5cǚF}���~�/���7-=;��=�`d�M����`d������$i�wPq���[�n��[I��3����]���(��9����O�q�'P���*�ΙG�F�VDƸ��O5D������*�Dj�I�_�W �3�S�6O���Ol�$[���31��?�fwͲ(֬O)�`�q���M]�rb�Gڌ��1���$t3��d%h6�^�o���]Mj[�k��_P�3�h�G�� �:��?�M�Y4��+�-%�ny������*�q9�q^u��G�ee�ٗC����%�-�c]�rZ��뉞�/��F�P*�T4[�i*'�h;2�m�s���,�)���G��K�I�~���I�2 E�X�3��̙P���~�U'A 8���}�� A�dT?�)��W�[�C%3���ͮ�K�;����q����,s��bV
�l�?id�d�A���Vo���bW,
�B� S�����dMwY��c�%��0N� ��-�}�ygA(ȖR���P�U=ѹ�$8�U��e�u���f�i�ka�/��xn�4\X­)�9y��{:��m��4  ?À>��x��#���x��0Y��<O���Z�N3��H�2å�P�jz��6�Z�)�,3��Y�\�oW��Z\}5���k}�b9S�	�m�nP���f���fC�����9]�m���+G�8Bn_D�M"�Q�JS�8Ζ��-e	"{8&Vb�)�Ef$��5sIc|?��������7��A�M}l�������S\r�����_��w`+�g|�z��]�$01&��b9ş��������e9�o0֔�t��2�Ͼ2��[]��R:Tla�̀$_~q�?To��0�����^�� �K���z�kr
?��l��L�m�    q���5�����ÌS��S۞�&w��`��X��3a��*1���i�j�==B��k�]/0�&�F�̂;���KNx���#=�%�*	��;� ��)`H9��D�pP����kv�+��w�lI�
�S����1b��JkbU 4�3�1�H-[� ����O�2��C7�c�&[@���o����g�r����cS~���O;8����+H}%F�0~}p�Z&� �g&�%Hs����k"��R� �u�����+�i�yZ�
�+'r�Ʌ��{el���!�f�]�	(��Կ�)°�34s�k�X�۽���$v���Q���h3NQB��� ����=���%�k� j�N������p��9�h�M	���G��n�p�-J
25�3z�d+e<���9*�Ϝ���vV��}�0�M��7E�ׅ�Q�vbPh��Q`Э�~��6�v�a�#�.�Wbm�jV����K�n;#�>���[8L�"��^��{<]P�w� ��;t³x�"/��A�ɛ4w��k�#�fف	G��AR�<u�=��榓�Z��B&��-��v��g�]j� m�E��!0�ijo�K��b�7�� ��#;pUlڙl�m�H�L!���h1�����DI8j�>��
^��(�!P?�L�}��c����w�H�Ns�U�`�~h���Q+2>���6#�_	�o/X���2Eљ��۟I�{��������#� ǟ��{3��NRk�B_��+ ��% �L�/��ZU�3� %�2��<�P�ٵʝJJ�9	q�F�v[L�M�r"����R��C?1� ��\.�V%7���4l+�ê��|}�m�I:=�����^��*��g�O?E�c2�l��/����}��$�n�32�X;���Cז5�GQ�Q���V��y+݉�}� �7�z5'��46\oj>P�FF�ȎXěF���~ 5w`n6]�)6Տ!R@�/�(汙󾏌��(Ɔ5��M�XBnҥ����=��{�
>E@��Xe&b5�|��ַ����
� �M��kt	��!@Ȇh,l�ڼ��7<s�V"��'ᣄcɦ(_c_�A ��i%�OFj(��	�`X�n��0�'\���2�U3����*��y� ����,�~(�Y_L�t'U���J�H���!��!R�m0�`��#t�� �#�0u���V;�H��#�4�UL�%�Z��Qd�4�K˯��T�"���:�BΦ��KW&J$W0�CKy� ��0@�ESp�h�IR���A��g�_󺢝6|[�#�m��iάXo
��� �U��v.ӣP� ��: ���J����Z��ơO�ܔ����?7�q���X�i��Be�ړ���r]�*v�%�a��^pK��$��a%n�r��q�|X���Rz(����h���#i�#%��#Y,GbZ�l���3%�dd�E�r١� #iYu·2%�w�x����!�X"�N�sGi�p��"*	�^:D?�%2�&���}��8�縱�0R��\=_�����LL�+{�mI���f���aʴ:��e�-��q�!5�2�UC1`����s{x9��h�SZc{2��c����1ڇlN&����O�|#Si�������~X0z،L:�`[:A8��	¿=�]j��j�Z��4Rhd��9�����x9%;j�b�� A�bI\^�^�&΢��!0�9o�* �;��66��^,�e��L?=�H�?Mŝ��d��;UW��Ou�	���_=���5 �ɠڵ�b����_6�`�@�47�T��Z�r�R^(w��li���`�^{"MVY��\5�,V��w&�-`��
�m������S��q�K�+g�A��@�2��c��(C%�h�p��~���.�M-Ft4��&��a��(���˷骡�9 �q��< $h��PCI�϶�=�(�5�#��^��n�]N��;�E�f8票�-3l4<��P�ܬ�-�a�~Ù�Kwd��IO�Z�����[�5Q����|'�	��"O�y֍~�N���
p�\|�ݑ'��䷘�O�Я�]�?���W.L6z�	N�h���fҎQ���R�+T���'��ջ������G�Ik|���;��I��Vƶ�E&G^�L~4�� �׶�$���wi|�����tAG#�� 6�w����A����s������$ø%&0��l��3��ѥ(�}��.zI�pj��q?�dĳdLWR2vژ&�C�zg���Xb[6�%��Ft#$<� ~�.F���	�El�{�)n��O�)�S�#�K���pX~j/P7�=�4��`��V��ȏ�U�%u$f"��s?m���S��B��y��r*\��\�ܱ�Y g��Q�-)�c�^�1�ډ��+Ð����X`���T�FC,��ذ��U�ʭ.:�&��L*a��(('�@~<آU2Е�٣��ѱ�b�>� �̞�Y��D� �3���y��))�⦈�N=�o��ż˛���p�Tqk?$��Τ�KK8��0t�R��O�v�1Y�,�.�R�1
�t!Ry������|� �H��(�"]�﬌��T˾�U�w-(L�	^|�al���S�h?C�W3E�8�e�)3�a�ht�}�;�<�6"O��1����oyр�P����U���8niZ�}�]	���r"��J��2�5.�[iqL�Qw��8h?sq;EQ��wi�W��#�3�~��,U�xL)�%/�L�ื���(2��I�c2̧�
�J3��j�*��,f��C��!nb������1�����?��c��z��UeԏXl�p6���r��J�D��@ӝ(��$��q�K�GR��A�;+#�_r�j��Y'J�(Ȁ��t2��-�<Fqj!�K�7g(+��XP�i�f�b��WL��*����&a��Y1�3a�3�x6��R#Ӣ��/�`B�rG�'ۖ�x��r0A=%��X�
��%zF�͈M�T��0 G��|"��"�S����n1�[-b[Q>��v���K2Z��d`�J��� ���4����{�XL�R����FZL��&���AȬHRԘ
S߮i�Ik�_q�5���&����:�˂�o Y�1�<���f}����J.�:����-cen��ʘTR����q6ƽg���?ڦZ`�]c�3]~h= 6�-b�Lp,)��V� �D&=��ϒє0�q� �W�r��g�A"��"����H�c�S�~XzkZ�mJ�1=2����,�kR\�yUyU�M�	��i�J�7VU�U���̸NOtP��.�	h���L�Y"����v�
i��E��J����1�|ܝޫr���?�Ɓ�����l�eҽ��<�ԋu;�>� �G��=(�ҕ-f�.���?e�o��-�o#�;�۠S��,�%"H�� 8���]�<	�l79��G���Nr�B�=�#��3�:��;��F˙bA���H��z���&�mS���;��?�?��� |��eR����=���R� �j�z�΁�`��B��K�U+F0�.O����)�؋��tCm-�d�#3V�\��������Z:<�'c)�K|T��[�H;#�	���@�;����ж���VHrC���=�?C��v�l���xf��6#���޽.Ўt����� ��Jj0��x���UF�r��tGǱB���O�5��5FU���TA%d�^���Fx9!��r)]� ��|��7�R���ta��D�g�rf�x[�	#]��t~��|Wq����π�"^b�h�����ZT����(=��$�E��(&�͸��� �)z!��'D�|�l�"�l��b�5Ѽ+�c�!{�o����ޢ��ĎQ�׀��=�:<���٭��q(��c�?�[��Pq��g���4��S�F�0�e�9��������P�>e�/C��U�J����7ꧠ����B��#�|�w��b�pV�,?�J͕��T!��q4T9.��03��<<�+�ў���3�B�Xc��l	F]e�7�Da2��-�o���w�G4�*���\PpL�����?�\bf�wۊ��&�����QE�Y>����c����    N�B�ߴ�É���(UxT�r�N=^B�D�Y1����J���*h�,Aı��S�#Ү�t�v�� ��Ƶ.�j�����8���2eT��k�E�O����g�eA,��8�84�ƴ��&�w\��n���!�'֠�p��K���}�j;˼����������Ȕ��e���Z��WR\Ͱ�Ug
b�lp��RV��8ѫU# ����/I�=*�FrwU�l2��m����S�4�^)�8	������I9�)�I����cڮݤӈ{4N"{�w�B|��u]���xdncG�P�@�&:<h��q��ڕDPI��@ �(ǉ��{���/NG�V��P,+�!�8�©l�S�`�F����������`[����k���7 T��]	fR��������dN��Y�
V��*��J'\R��/�*����2��R�@gA;+�i���vs�g�FL�8�v�ҝ#����w�X6���i<g�gI��|oN�A�w�	J���Xg٢�NM�8��S��")�ۉ����
Xf�Iҭ=�4���&���a�Rh:K&�,��(g��V��L��O��FLT���˪؉	����!�L$�~&���,�"�CS�"��A>��H)FdՅI�!AU)�Q/�Z떔V���W�U.�H\�"Ǚ�:	l܂�z���߅����?9�d-�k���6C�(�ZR�����L�?K�і��G��u��̼35�|�{��{�nZ�3TȮ�V;)��V⍌�������A@<�q�����:~�-q�^��=k߰���v�\d%���3�>�ƽ�疚A�x���6%�15Z�g�-e���\h3ח�z�#p�oͅ�x���-���a�к�DMH3Z�V��P���5*?w*�Z���!��"Ճ��j<�VS����)h_��K�w�q�$s@��DH��!�l.�e;Q3R�7�|��x��̕t���#[f((�0�s����8;)�^HԪ�щI�M@"񍸾��o]�3�M�r��]]6ڄ�T����\
��1%jNڮ�=JgY�C�'��XZ�;	��5�
3�`;�O����f><\����Ԛ^��ٱ?���!"��n�b�9��T��$���}'�O��2�MW�,	p��0*�s'ۻk�w���iN7�p\"G�j@:C�������fBC��=;���FӚ��k�¹���9Yp�r��$o8q:��:s��ժ�MۡhkM�sS<��1���� ei�o�ב��Љ
�s�}�|�.Ͻ�jR#�B����NWζ��ő�	*�/d��s����?�5J�;ȰA�J�bI׃�j$����r�L3'Q���,�7h�dق!���O�P�5++}��g��T��k��?����7A%�������������W�j��R����XI%j7Jʿ3�EL��L{�YD��(�h[L1�z�ۊ��T41��p��<�<+6�x/�����j���j=JP���]��?�p����+<%�w��r\e8-l_�n�W��M[;���y9ԙk%�����nӲð�K��,�[	�K���T�'����(�-fT%�QsĄ|�x�X�g��p*�wc�����_fƆ��{��9 Im�ċ�<��4;��dH��4�L�[F�4Ա򑚛]���\�Tz���C��N��u���$�d��G�?ӼRs��g_�@q��VK���kÌ�鿌��*$�(��
,}&�������B�������zKg��gP*����Pƥ2禞��Q�������Ho�w�V��/|����wB���$���c��k\۴iIۅ�J�H3�҉���P�E�p����?���2����� κ�M�Xn�������H'�U��%�zDj�����ҹ�����~�@��'��-Qr��M|�l)w&��
<QS��W�b�uG�����r$��6�[�Up���\u5;J��:����k�bcx7��l��fx1|��F� F�As�;��<�ZY՚;;@��:ke��u|�y̩
���d�͌̍5U��e��N�����1���t���_5�޹�N����fb9`���?�!�ǂ$�h�����y,�������#BgϬ潊h/�ưy�#��'��A,
���tv���sc�y����f�x�guF˹6��/�d��&�����g��d��FW��M�þ
��� mR�Щ����T�����kUY��}����6��#�{��O�9����z�!��1�Sڳ��)��73T�h]0I��u��v߯9���Ia_ۖ�jQ�y�C_M��np4ȡ�.�5��G��SG�����U�7,A��Le{+K�����=P<��6+�7@�u�Exb0Af����x�5NN!�I���:y�W�o9	�?iޥ���U�$�:��0���҄�aK�����nm�h��	KQ�5��b�5:9K���(��0"���s�����ྶu�>~lRle�֩K�KC�2��ɩ�mj��GtR��vֺ˧N���=k�Ol����ϴ�� ��-�S�*��լi���KeFw�_jq^����a]���9�������w�,Ås8Y�(<�3��q��W�����`45�Ϡ�B�3�����D9��)y͛n�I��a�1ߓ�x��ڌ���<���%�� &������f:
�]�q2�pn��ō�J)�u ;}I��/�0&
��Ǌq��ڌ2��H��Qe/0�hS�J9�
[���:[\R���Уj_�|s0�CX�S�֤QF��1}�@2���e,����I���H��UES���'���K���u��`ބaV|����3s�P������ci���F�zãQ^�~�,'�+��ޮ��I7����}��mtK88�oXߟY��+{��wo�n�o�����5�gAϘ�a!�n��R
>8hO��d�O�9��g:Lr@�?��?����ki�-:]��1H���,��:5|Fa�f/{86���j�RǊ�Yys�M��Qvr��p��U���&7�k�d���<;�/B�Z͐=�Z����ѳ��E��Ub�W�S���Ӊ��=h��v�bɏ����L�ݟ�8�����x]�_���CF��� �hPn%t��ͱL��ߡ�6��/���na9]]��*�����n����@Pr7ܡ��ԥ��A"z�J��ۏ�Wj%]�b����Y]��0}�/�}��ę�>�L'3��U�R�M�O	���ߔ���$<I�|��h�-�����xb(��+-÷�(/�s�*��A_ʺn�ZJ��Oj��.�݃�՝�{�	����Hx�p���7U]���+�{�̣��kו�����>�q'�x�gUq	&kb��
X�#�Y��*�F2Ȑe�w� � c�M����`�}�P����j�(�A�nW��č��6P�<}N�Õ�ZfQC�}�[��w�Fa������]N>�E?5��|�0����	`����> �N�A�G_��|A�1���ھ)mk��yL��pH��C�$
5
��?��ɺ#_с��ķO�;��J������nĻ�Y]�(�C�A��aH�n#�}1����t򦴱w��dy����`7b��B�0aP��K�	AR����lg1ۺil��#6����M3O_[S��Ć_���Ȁ.Щ��1R°8��;��hЌs@������`�,4\��KA�G_V�b�f,~k>��+8�����=�t��-��v���f,�1&*7��C�AM�7����⾒��`a�O|k� W�����۳�7m��u[Xt��E'~*u��R���D���A�V|J�����^��|{�U�MR��e�Py�v��:j�2
��?�0�7��+_�tyn�컮������j){�I�����Ÿ�D�AOuP��Rr;q�;1��I��M\7�� ������Xz��������9��pfD�ɭ��/b��Y�Z���I�H�A��h�"
�ۍq��2Q�T�=�{*�BL�i��$ɞK�/ҍ.I��mR�C�SLq������S��7̗ƆL��,"�4��Va���LK�Y �b���e7��/�Qd��U���&�9~����#~P�    c��Z�M�l��.���6أ���/����~���{9���ut���x+�{�yP���AL�j�G�ڮ �O�I��51��dc�i�/ ���$��nr�ܯ�02*�3���<�_v�ҏ��}c�TYt8u{.�&O����d�Lap�$�U�T�V:t��6��\��1��3��U���;�5�V��**�h:5��D��C�K�
:�rcs��s����`2b�q�ʳ�N'�_l��� )"���D�v�gV��c��k/:�#�ES$N��AXz�uLh�Ծ��)��0Udq濐��aߑ�E�?�|J�%_�O��6E��ͯn�����ҕP^�-}�Ma��'�[��F�MQ�e{eJ⋓�6r�Y���-X���^A"�Q�s�$��5�t����4J�dڦ`̔��_ ��?�G]��C��#ܽ�s."\��q��
e�hK[�=o� Wb?a����8�[�[&�}�Yiߍ�6�me��ȏ��ū�����t����s����|%��A�"�M5��S��*��UI��63��g�{1�w��C M_w��? �Z΄��TQ�#c��M��>qbk�NU�B��x=��c6ϗ1۬��B��=h+W]zP�c�To�:���-4�����]�Uc�U�_-�kr��xS���z1��ڇ��7� ��l��,=��]���L��>ѫ1���(��6�U2f�}�̃��K�ֹ��^�~�������K�l�o蓻�˲S�QՏT{[�i�ϸm�j8�Kb�W~���.��s��ޗ���]Mp�m�q_~cz�gMX�DӸ��)t�ry�vsh�M�fA��\;v�r3daA�a�����l�g�7�-����O��^����D�lK�
�b������&PͫA�g4Ʇ~pP`*�΢O�����QFp�Ϙ��/.I���D��\N�n��5��ސ��,�FhaI��i�VK�s���^�� }j=@����a���{>�d9��	����(�m˸f�B|"-­y���ø����QO@�hG=!����m	 O� �.)�G/��c-��
R�
b����p:�)��WZ�i��x�m,槜8��5>�A������8q�Ac�f�'g�
0���T,�=�1FR���Zd�"���1�����15�s����ķ��C�߳�@܏l�!\"Z���Ʈo5��/c�@%�����xt�,��N���7P��#�xv����V��������p���t��/�9����7V��)O}'%<��I MIz_ip�u�#�e6&)�JB���$�(7"����iY������4��Î�q"���|5��� ��x��6�C�[vwHDM�4��E�ѧ�#E��@�(�j۴���pjÎKO2��O�L�EC  �S%�B1�{V�}�d�lndb��Xk���cƪ�}Q�ڻZ1��P�t�][����O�;��%�}C@�wX���G�c_�"�5�~��]>���\u"d�~ OX釠؝���\������Z��v~���fs=@����گ䯰����A)�9< ��B��u��Ύk^�B*���}�sev{"v>��~����\�E�4ycl�I�G���8
��'7h��v=Y.��rG��	�B�����"/�X+T��*�L�z���3��V@�y?�	g��]D`���1�����儎�p������)c�.9Ώ�Lnb�_�-���ڦ.>��zBe)����dkY���7�M��� H��cs��.�R<�F?J���v��^,�/1L}��t	�l*KP���������9��Ft<��au2�lg|M���<��G�"hȑA�"���ي��=�;�h��b�w������_J�FJ��Q��Js(�̊�CU<{N�?^���8�
{�m�	�H��A���e�-G{�G�[�s�����ǗoG��c��H������o[�ԇ��d5ﰗ��V=f��Z`6{�>����A�@v`<�����$Q�}3?��n������f�����L��@R��#���)��5[
�dt3�4$��T�mݔ�K����[�!M&;6��=r���.!݃�ٹ�a�Ula����n;U'Pe������[zg���t�3{{HV*V����/�#mAZ]���R���Q�_�-�,��΃%<W^i��U>����a璵�?�E)��.�Z|����,p_��,7b�e+^�6��I���q������{�:��0�3]����1�sVHx24�s�I�;�?�GGO2 ��87���>�vޮvQ5�~�����o�Ƿ�n�=�T��]��b��G�r���F,��"z5�3Y���{��HW�EҎ
z�-T2ۙS{T@���S$F!��K�n��i��rѭO�>-���M�\Bq�8{M���2O�Z��[U��%�bp2�M � 7X�\\m�5��)����=��8:��u��wbk�e�*�U{l�y����j����h{(k]� �����z6ce����|�W:��-r�h9z���.M�B~�q��ʇ�(��&D��)ak�dFw9(���z�2D+��F�{Ns�AR�L����M$�9������"Jx�Ö2>I�[��U;��y��G,I�6@-8����O�cm`Ja����A�S�"Z鹔E߯�����H��@��Bx�j0t���9��aafPX�F�΁��_{��m�C�?�o��7�D����b�tC�hǇ*R(�p?9�<�jҹe|�߼�ܶyAؐ��F#�B�z9Mf�Ȳ��1��߽레[��@%����6�*��W�C6Wg�y�`(�43&��]�E�p�#�d�-�ϼ|\��G�܄IV�b��.m��[ޥIVڰw���zX��F�3�S�s�V�#O���]wS:��x_u�R�u�ͬ��xʈ��W\ʰ0����o�%,�*&q�� ,�p[u����"��h3�aE%���\�#8������r~8X�\K��8wv	����Q?�F��i�δ��ɵ _s��?���S�� ��)�\қ�i�Yh��܏Åe]�[{s�9��Y��B^�%�r���۴��Ҙ����L�Χb�w��+��mm�^���+�G����~@�Ǯ�7�+���AԖ�Â�8��\*�J3@"�B?���^��>�h_Q����>�����^��o�'���^��#o�9]�/kEoCSZb��S.?����F���ub��t��h�{\D��fK�&�8~�s�V�ܜ.K�M9�21��X�3�!��tN3")��+�������A-�w�@q�j�Ym;���~��Ws�Տ'|��P �)�y�Fb8UՌ�j�ײ4�߰���S}��>�<j�a�7K�@��� �>��rG���f���V&�Sv��m̱�4I��P��)/M�-fpE%��=�Ѫ ��ꨝ�$w�W/�{���AO?nXʍ+O�X@��u1:�1{�`��=L>�J��Ga���g�'$L������u��Q&i���x��S���F��i;��w�3՚�s|�f���9�u�C c����E���Vᛱt���^j�x�Z�?�E�1ǁ&/.�w6Y\޶�<��ֶ Ј�m z�Ԍk��s3�U�LO�{']{�$�Z���GG�e[���n���Mb�v�YD}��l*ղI}:�̩ϛ
����Rp��$����%��h�1�AW8Ǹ�/�L�uk�SF��>��(���ەԈ���rDZ���oSz�5�i�@y���md��{6�C�������8o1�p྅�{k���d�@���OP�ϏW��~������$���E;A���.4ˠ�H��|!�:v*��r˿�4�O1�|��C���ru�A�����S�I��?x %('G
���bE��܁0�����,?%��qX��á�"�7��.+��q�s�AZ\/���H�4���a�<��V�2�w>&~"n!�g?po��� Й��>�@���� m���u)};�CT���ilF+�v�`^ج��+U����&gx`/I�P�
�=(��﹫4�,MmW��T�e��gs��    f��i45�a\5IS1���f�SCHS1����ȷ��M\��^Q������6����\�qi�+F�_$�a�^/Յ�h��-��d�-	Í-����4D�A��3����m'\��0�87�	i�ز��d��Y��ꦹ��,��t�`�mϹ���mY�{n��^yNk��x��R���!�<�[��N'+<����r<m�婀�Ei�4���@��"a@޸LqӏY���<CN,Hj#q�0^aP
����>o�22p ��q<��=`���p�c�Źwv�c�f�������������_�!�䞸��Ql�Z�W���n���t�e��_ri���[�m�oo����u��0\��Q���N�X(j��钢(�y���3t��V�{0UsGn@�6�����S�i�M��7 <A�������4O<�BP�*�e^G�~ ;�M�GX%ԡ�}h�B� En�`�決��!T0B�)8P�$+��te;��%�*L<�>b��������_���AR�qp_R��}Z4����'u���ř��W�xr�h㢞m<�&q��˯�jq��lZ��0"����0�R��o�Ua`��h@���Wߒ7_Y؟�~�K5Cc����@�2(��b��\��_/�q�Sþ�����g����=��a��N�9Y�<�Fx%>d�hiY�?�3��1�K��*<���r=�6HM|}��b�gN������#!���tL��~_6��	�\�o��3f�d��Zi-Gg�����gF��zV�e��|/M�=У[���S��.��ul{<�j13�Z��j�oaLV�~5j��+�z"g��}N��S;$������3ۮ����T�vn����'{�(�-��b�-�H��Eir�J���ɚ��������ߖm�>��F/��֠��W�E�व8߇�|���}���״�F�=6*C�[��vUd���Z[#������݅�pƈF+���YO��H(�8�Y!ߛ�}��+��DJ썧�����f�7Zc����-�Uո�����5�Z;�nnAs�A�g�q��xM�H����(�هA<������߃��ecq���T#a��eT���M6�mO���B����l��*��l,������[K�ٸ�%Q�{˹�h��r�ĵ!�!��ͭ;����/u+K�F�׎qh)Z2�P�c����W!��9;�V��kt�u��eI��}ĐR'����%y<���4�LN|�Z������^W�є���e��/ɥ�#�47�K���r��l��ImW�8�Ó�U	�~���c
��t$�q�0b.��I��d��H
�!��4~�޷��6�?���,�("m���ن�K�BLV�>r3[Z�&K;��P��,-o�\�C��w�d�m�K�}���A.�vV�^��u2z�=^����h�&�<�@�Z� �E����ޤ,K"�)�w<��_r����۲�WO�b�)���M�R�N��j�g
��_�;��YVF���.�O4R��D�}���v��pʮ�b׼��M�z�
�1�dM/wn�	d�d��D��Ƶ��A^D�L�vXj�紝�)O��~49C��)I��]���=��x�ql�;�)S����ݮ&�C�r�$�@7K"-Н��J�,��yU#�����.6le�ٺ[�5���2�� c�g�V�_H���^�e��r� �a�S6��{�9m�S��`��}�ݾ�ڻh�d�د���7W�V  @��伵W����h0!jy�L��
����2y;�Ʌ��s��P��l�i{(�gEa��&mѸ

̙WYQڧx~�sA��q�.'�B	�U�Y������?�+B��j�F�xB����k\o�"
��׬+7�����H�a��b8��P'gF�ňV��2�˴\}��)�V���Y�3+�i��h�C�����Z����mEv�׬,�N��Ҹϻ]�/�`��K�v0:$/(e��β�C�[��+�~'��f?Uk����c�|iK@}԰`��0�a��ޱ�$���A������p�n�umV��
Jx7�kx鷇�xܷV0���"��)��\�k��U�6,���s
t��w�	ܰA\�v���-��o�8D�/_U���3<Y�b�Y���X� ���
H[��?P��Ȅӥ��ކfǟ�0��f��g]�r׍,�
�&Qn�Xn(����TPia<���{=�ɉa���5��,�͊�fؔui�@�h*ݛ.:U��jo�_B�{�;��oִ\QxÒ�*t�Əԟ�K-iw�D�?�^3���h�6�,pb-�G�ax�]l-r�5���^��gU��r)�x�VC8�z� <уJ���bf�9Hˠ�Pz��|t���'��Kv1�Z���x,�-Ztm�Ѽ��n?�����}��$�ec��Ǿ�%�ll]A�x����OB��~".��{vo>NoiC�$�������4�z�� ��l�E�\�3̛��|����aX�|;z|@(+�|�����k{n(�c��HK(� 	��d�T����_���MZ�[�?7*2�}rc:���!O�%wLSɓ��Soz�!:v .�'���C_<�|V��'���kF��Hss��cn���=�D��2;A����X�h� �I�p̢*��4��Ԋ�$��T8�xo�㗨="f+8�s��!��"�����:� ���ꟻьy�9��{����������A{eqdM�2���tgp��0(����V����:g=b�2f�Dh�5 �l
˙��̠8�����:� �<�q�� �!�J1�R^�����4�q@	9��Չ���һ��m|T���~�1�����y�۴rN�X��e��N�ao�SJ�e�0ڪ�i�+o%�Q7����8H3[#oթ���:u��Y����ۨr�[�,�<+��ߚnё)��_p���pj#�P�������<O�	-�ᶝa�S�Km�5�`\繸����<O�Vl�cu��n~�kV���/(��<g�����c
?؞gq�-�T�Ks�b��P�Y���_��
�"��C���x2RV�6��B� H3Y�{J�:;6�+/s�4��7/�1�.O1Vs�#FJ �eD�G�c4�EC��)ts}+�x�Ζ1�8�-�[l�����f��}[���KIЇQ�1IãW��6-��p\��L�p�Zֻ������a�-����Du�1�A��=L�/)H��w�G��V�V4��n���|X�44�߻��e�:��lKi�Z�O��6lS���h��P�B�1Г\!�6)��ͪ�X!!I�v����Ԃ�V
���&���YNl�2�����q���=:�N|�e���]�֧oU��F
��r{p_�t���9?Y��Oi�8��ބ5�%|�ևȳ#�o��Y����hu���%�^���<5c��K���`������v4����:ۑ�VR)�@sV7r�/�|v��ƶ��Y�� i�tI܏O�!����`��j�^�N���z �t{]fÐ7��3���a��ۂ�*��km�馕���['@+�G�a��1��$�|zƬ����k��˧h2������n�k�DM���6����x{�/i8�@��T���z�o�k	����붷3n�i�}�3��n�xz{��pNI���-[xrQ��P�b��F��,]r�b�7B��}'ݡ�F�Z,�(�e{Rv��
�U�y�Mï�p5� ��^��[��l��O7zZ�>ʗ:X����;9�����@���#
>+;B�z�O����fv�%瓙�]��%�IfA�b�̌ò��H�Y��7���H�ð;rX��5ֈ�y�w�\���?as������ۮ�+������������#?g��Q���w���w�M��_i1/��V;���ɇ�Ё$�$��<ón{�1�0��/����ϩXtom:�2F2��qf�ze3]O8�b,v> "�3&V�FX�s�Cޣ	4�pff/�9�������u�3��h�/s>$��8чV���I    ��O��R�����0���P�N���H��L�14�vך�H|;>�����ω��S�"��#�p�a݆G��"�~���j=zR$���?���U~��J9.���e0Y���Kk�T�&MQ���m-7�!�-�T$��I����c�i�E:�m�y���I�0G.N��p��b���<?��ٌ	��	0��|��r�ŃT�����0Y�#1�H3c�5���6����B�p��z��A$��+������?,�l&Za��%�G����0@��J!�"��L.x�;a����b/�IJx�I�|��n�MH���΢p	?v�y`~���z��y�tV*zp�%�L��&2.�~��p��+�(�eQdZ���VD_�ح�^�Xd���;�/?x��j�u��?w����ɬE�j�����pr�˰Ȫ(k��9G]<���w(�Y�!,�v�E�!�e&~���Y�A�����}�x�y<_wP�c˼ȓW��Po-�Qm�y���P$+�-�,����Y����j���V'u�e��=�|��E����Ǣ�x;��,��0�~��w�!��<�<�� �o����a\��
�|���ghE����Ѡ�����2���y_%q�I��[�,�U����`��.M�\:4I����j��aC����)=�;��u�{�����S�UEn�jP�3W�-�9Ea+����y<�������L�G���������~9�BKs���K8�����J�=�!�,(�PD���)l�d�rz9CQ��."��\�@�/[e9wg��(��Aѳ����[���Ei�k f��,%���Ni����5nς͍���?hW�;��Ƣ����Sn�Xk��B�t�+�^��Wx�ro2|a7��DN��6���������Y,۰(�V�#�� h�V��WD�8*�d_��w��.�dp͹&�9�%��gq���j�L��8�TD�,��6�(=��o�b\,� �0���n|u�5Mu9;��Z�Ѥxb�j���U�j M�Y�V4A�Ρɉ��%���DX��*��tr��Vݾ'H���.����Ȧ���/v8��ъc�o,r�ʰ���[�r;��(���/�Su1
�2{�<���(����r�0A+q�a���;��$I>��qe����RX۰~�\)P���Ԗ�~��1�Y�L%��=y5�EgF��Bŉ��0�Y�8���}oT���'a���N����!��D�t�]��x��v?lW�[@.���x�ܡ���&��zey(�b����׈�����DSĹ>��ش���<[��`e�	�U4�+��Я�e�ow��ڦ t)��N+��G4�#&��@q8G�c�|sy���ȣ��[549��|��&��D�*�/=���&[$H}��1�g|9���|��3Fq|ԮD��
?��'��ʱ8�u�d^ܾ�p��w]<I�4�j���4D�W�ڨGK,�U�]���4��q��@����V�� Y�Z�Ϭ.�?���̎C���c�*� Nqd0���{�ҳ�8DO��q�>��a�'���5��vG��}�_��#�2�H o�L
;�Q�GW۹6D"�)�~��z�ʇ�z�\�O��R�������-����2��<,�/����� Quf��T�2߽k��3�b7K��~)@�G��  �%�����ytF�P��"վ��m���1|���J$�Rw#��
��u�S(�٤�vz�lY䔖0m_�0��0ow� 1��)>�]��1��U��s8����u-�<[۳�kb���nu�-6n8�Y���������!���3��ew�Ai���>�P��0bk���b8�m��N���H�	��axFŦ�[�	W?��H�:��s��K�F���Jy�v[4����t;׼� �lx�� �]fb���K��S����S�?��{h�c_;��531�o�T��Db�׳�s"k�q���\<u��B;�L��a�������ޚ#�ȝ���?�3�bD�s����\L����������nOe4$����Lk�2��mj.�]�5�#�l�=֣��O�ߢ�,������yb���Mq���`f�`��a�K<� #�8�E��Ą���Agr������Ã�:0�+�����ȍ%��&��` T&IY��}���|<���A�Vh���Y��$Aj�lU�P���1��L�'�M'�Ѳ��,A<:؜N���Ǝ	`����'�b��
���Z{Y���_�>�L�O��Q��-���AUE�����2�[�B2#�ͭ�������u�[���o��G�P��'�@i��#DQm7�y$�\NѾz�UtY^XA#�}��LȰ����t�A�\�����W�@:���n,�o���)3����Ԇ��2�9e�ˣe����r<�r�r���Mׅ2�-�J�`y����ʪ.��.�٬#x4�2R��}�p$w {k�A�O*���f҃_�E��$��?�,Ny]/ܧ�c�t��-=�e���|jA$FqNA�����2�R�Z���	zX�>�)Bbe���gz!�~ЭN;.L���x���8���Y����L'S-P��tC[Ļ,a<�1j��ǆN�0(!��!J�r0�����6��J	Kv�]a�8\�D�,~:Q��0o�x�W Ќ}Yޚ�?&���k|��������oģ��x�s�
������z�u{�2�����=fI�I�����WK�H��B#~�ﰫ�{�۠2�N㕱�*F}pU���O�1�T*�ĉ���!��l����Ⅰ,lT�P�����bᯮ?�u7�>�G؆�8��j�F�E��ې�������&k��&L�=J=� 7i�l1��*����)�����=��V�2~�C:ɟ�D�7F5�|j�e1oW�L`�Ʈ�^��`�w�Ō�M�Iث#TR�nn�����Y%���?ΓJ��1w������ �q>��Vq��lg���dgtY�Z��^�1�H�ߋ���P���l�TŞd��D�7���^m��kURŕ�7X�~�}�������^����D��)�%��a0�;�	7�ϼ�-<1U*&J��;���-�����pn��|�K�JOâ�5,h7U�{�g�.SV�4Ȏ��<1�ʬ��r4�R��P��(���xz�æ��z�W&YT1F�D�
/�2FR*�Ⱦ��[i	�HY��{-uA%��0�-K�	�2��Vlӻ�7���:Ub�Y��4��M2��F���Hq����������|on�彸�o�d�\�}��閷Le��@�P���ōp��I|ֱ�.�xu!Ciˊ�*�pw���H�I��^P<�
K/,�����Ͳb�ґi!����04�y+ӵ�����y�,W�l��f�O�&��,��nw�h�̼���L���fRY�� �yy�mnX����|;?��7�16����V����_dO� ���zH*��$��o��n��;?�+?�f�.����d*UP�P�M!(��;�#�+j��O��h^�p�[rA�.m�����?�q�p��%�޷aN1���b(�a���yK�SAxw���{O�g����/ݮ��C��O��.:�R�[]���) �����|�8�q����ˌ�Q�l�sF�����;��{�`=Ym&����{`�v}�cӮ�諸EƵ�L0THo�
V�U�@��l������o�6���(�_l�[��W�3-��9��W|u��;T��3��+3��� ��v��*�aB`}?� Y�i�=���ƫ���>�ݽծf�©\�S1s$���#��g���1��h,��	�u���5���?j[s�σA66�W{��ўu�3-Īz�50�����lwZ>�gOc��Q�۪r%��05��f&6%$�zB�_�V��y>��Z/g��j߳�V�%~l�i0eΌ-7����F������o�.��+n��M����N&g�S�'�IP�v'��9]�����Ss���%�kWЮD�wGtW�oK$�%(�9�o�YZ��o���#fd}G��IwHͫ����p�?\�u�Č+_�K�/�jq����d
Ae֖    ��H�
̴��l-�J|�$����)������m؃�v3�=���.�S��[U�`p5��<�24���`o5��}�6L�[I����;�xy��\��j�#�i"�쨌԰� ���
�ʸ�v�k��1�����(���0+a�԰�����wںn ����_���k�h_��� 'TpL���S@Z���S�A�X��Hצ&6\�ce�kW�'��癭ǵs����P�09� U��ٯi�j�t6�X"�
R�]S��6=��U'b�?y��Y=ST��q��GA�	!*yԢ`�d�y|���f���aX����"� �VH�N
[I.B	�y�!&�rԉ�9l	2�}�5��N*{����I���re���ԍР^5zu"^����;lW���^-^��d��g2^�jC�ˍ�$_�d���U��(N��w����V��._��D�����A����>��r�^_o�ʌc=��b9��y�Y�
��V[1V��#���_kCY���Ñ�#�a�#��"�7:��4i>7��K%#���.�n
�X1~�7��z�A�hw,�b<̟�����G��"+�:�}���e��(r*Xd���^4=ej_��!�Ǵ�pξ��k��+D�D|Q���L��}��u��"����Q*ou�u�R�<�<1��S#\��4���H�� �H)��P)u�������h�4�£�_!�fNQ�VS��єnT]�X8�HO�p����+�^%S�q���-��)�u��
�%A���Ų�wYd9kO����R�ou0��=��_�T����,��;d��X`M�}�_Ζ*��!(�]�V�g�'��t�ANX����R��������h���:Ͽ�,X�L���\�V���8�a.�f8���q�9�O���?�<(���b��K!��;8��dF�b�wt`���'�ϵ�Ԗ�²^�����������A߫��r˫�����q;yn�kw��B��Xb%
�_���/.�ê��e{:Ymu��ei���3�V��d����Ϸ����'RQ~!`�-���'���$��Y�GgK�ץ���(k@��i'�� <���-�>ApP���;҂2��U���w�kKk���V��2m&�L�?Wr�aO�v��B��t�;#`m�� m�f��.�6V�-�s��8�#�w<=8ۆ�9Ɇcрn�P@l����:��`���R�,�	��:�d�fL0�)�����H-^�"k����@Ә�'��b�m�����9|�1\���H� ��4׋km� �0�s���7Ŀ�&�7���r�n�V�QW�}4�~~��t
��V�N��yl-���n�ͩ�Z��Ҍ#���H]���1�Z�*�}�7�1��<�u��ȳ�1�W�g��}���-�c4� �����R[]�6�wh�o7��T�q�9b�l�;����ٽ(�5鋱G4�ic�ǒa��/�n�վ�=2����u����b賥J��F����5�nAvcT����_��Wo�&��@����&mĦ=e4�f�Qp}e���Sє�^@f�8(��T�L��vO]#v����2�N�Y�6N#�4�ڼO�<�I+k�dx3���(�%�oh�!�P#x�uԡ�PjB�1��|0	�n��,<k�#�\6��jn/��#�l�f�o�_���t#��SOAW:��'��aN�}>�{���CN�Kі�;/Bk�.~?0�/�/\����4�ƶ╕�`S�MΕh�$��/���t�^zM"�~Ĥh+��v'M����Z^+x�Z�m��@��S�Òx�Y�/��-�m�x3��92�y��Dl�"VYQU���������s]Cci�tm�-Xd���@j+~�E�j�3g����?�=)'�ªeCJ��2��0n���t�P� �&��~ם�ᾢ��sd?F%�|s-S������ٷ��g��dF�O��	�b'�)O#�ɋ輿f��㑠�ty�3����d�Ti��S�����YS���r !Cln� w����Y��_?����`!�wJ�m���/��ў�@)3��п����o�n	lGp:5���`q�-b�ǯq�7�T��L��/�3�2W�ɚL��������ݟT�gz���^��d�M�y��ۂJr
��������� �96��dby�)�� ��O�l�g6����"<�ۢ��Xh�X��<���i�y�j����O1z����.:v�&ό���������۷0���b������J����7y<泳�TݷS�����%I�<:��ѡ#k��v�Mq?xk)a��P�����1.Z���c��'^z���xղA�}@���=7?zMۢ���?q`�Z�tmuo��|M�ŏ~4�!=l���)�e��{��D�MQ�1�,SK�A����K�7�7��~�m@��QvST���C��痻�ͭ�Þ�̵�m��m|�N9v�py]О'ˣH��Q���z�>���������r7:ogR4ej2\X��v�����7��}?���ڡ}v)���??Q�#��޿��1+@��-���X��8b���2\����,Qє���4`Ϸ��J���pw�t����M}��+a�!}�}sr֡ƫ��F1�W���xL�fY%��Oɪ�kS �m��$�����ć2�7&�mP�tn�Wo�X�uKF���&����P.�p���N�������H�=���*�r�媪�e'��0[M���Ϯ�t��Rc��������Tq5k-ɗ7�tTE���	�H�Ĉ�⾚O���N�B��H�6�,�NѦ�Fl�>�����,�|t�'�����B�v\�[��h�2�/O���R�	՝���&~��PmĲ����꤁���޿Ԩ.���i�{�!<�_����-c1j�hM~#ʰ[�/h�������!ʃ���Uw��wnc:P�!��g����4��ıӂn`vY��=�`ʰB���&MS�tsBF��ֲ� ���P~
���cM$�;�,��q���xldW���u���r�T�@l��B��u������H���Y����h ʜ(Ȼ�=ϖo�lz��|� +�,�;�n�b@��U���@��}�W���h�-.�/,{O�f����-N�D��ф��vj����t���+�L��%�hu�����ԵSn�G7�Vz@�<V/=�jU�Z�߱=��#ɍF����h�*6'Z�o_
܅}D\�v7���H�8�VQ�H�u��񸿵�.�{7	�"�߇�� �o�Y���G
��9�����7�3u��<�����B��w��_h����$�~a0����(�(;�J=��y��t��gߡg�Ѡ���K�$��[�C�L�`S�:���y�+ ��
>3�:�=L�w�ӋK���3��t�@]����
=R��v=[.�����>8jx.�ɬ�ځ��-&J�>D�8l����\��M��h�E:S K��ڲ ����0 �� P����ZMW8l�ߔ��_y��b� /7C&��HB��m��Aa,�^a��[��4����z�e�;"�aD�t�w������bf�ݳe��cDc��`�ʃ�9$�w�fO����Z�H�)���m���q߰Q�4�XBX�Ű�`-�0�B-��vGhD��ß�V��P�Y���6@�I"{'GB �D�3�6�Û}t۰���u�k>�wV���j{ޚ���[x�X�9�"�[#P��-�So0��jFX�L(1)�I��34��� +�P*Իq�f�[�B��}MtZ�fw�|!��`>�����p�)[��V2�8z�A���״��9=]n����[��=�λ���l���9k��ϥ3�w� Gg�_���¿��ή������Km�D�_�\v�w)�}O�q���<i��I�2���g���ᥗ��ä��7�k���ﻤԏn49^��RxPl��Ra&�=$�|v�^��%Ў�Hm��3���,x������(ﴛ#ě���o�lo��;�����6�=V��p-�P��Sg���1�0��b˅7���ql��l?��xQ�-�\	����E;m��*���    07�e&��܆����v�
Dvt:A��Zk�c腕��Z�_�Dl�F��]�Ue ��j+���AU��`�?��'*>zҍ�7*ֺҊ�u���hcoV���:���k-'��7�[=�NѴ:�%v�'Cs{����B���a�e�Q�u�Ʒ��;6��V���Ϭ�d&h��m�+L�ni��K�0�k�A?+%k/*�6�Q7b�m׋`ז��?-�3 L4�hj��G�R��`���Ds�%)���t>��a����"�<dP�i}ƛ,���t���z@�|@�w�� ���%Db#Fj���WI�0^�~���vwB���3���A�9�Q�7�eo���� �� ^L #�Q.�f���0"j?Q���h\<vn�����-�B�9	�d��&��p�;;�N�J;-ցw�="��{x&|8�s�U|��r	y�d;C,$�E7��_v}��@WF��\�{1��;�!0d3���%}ed �=�Q����:��$cۯØ�U;�*y7F�Q��hO�3���=7�;�^�<7��$�Mw%褃�d����S�mĖ\�;kw�3c����-l�\1����O#�¯A�v�nd�/�?gwb�=��:��ֻ�h�+$IJ[��Q��嘋�+�g�po&s�v4��zе�Yw���^�H���ӳ�[%<J�Q3ז�^�Z�4�yZ*��хJé���%��23�EW��u���{T>.����E�6.B��Q�9^b@�Tb�CY\�h��I��Q7�Zq��*~4�»���/��f��(�o��v���7�`�]��T�1gPo!Y��)�K�/U��\���Z��J?���d�Û���2)"��	[=����d��8����G��v�n��Y��M.�-�Н]3IV�O[~�G����M��.�k���7�2��`Ϟ e6[b�e�-ᅃe�B�]��(�G!��kN��%{���9��~�0}�I�v=�͸��d�B�Y�k���<w��<H�����P��G��xz���+˺&6����8������������3�Q�o��y���Y$��_V٥k8OtZ,6������`��6b=��t4�ma '��j׽MX���i��/J�Hd? �)@A�|x�������݆����5���,�-��aۨ'*�H��i��s��$�Ȓ�����P���Bc/�v��`/�@��@˟	�o�#ӍPxWv�.�����V)�������#�3Xp�S�o��1Ō��n�&y�4�Jy���W�O��VI`�Un�=2��9̽pp�0�*A/�}W��.���(0�'��{BVVR�6��b� 7�;eᳰ���HĄs(m��)}#�!>~�J��Y��#P��=:��o����,> 6�v^�@%|e�1��ʎCؑS0�߽��� ��gM*1�;Vt*�����v�-�������J�I�Ei�Tڠ�/��+������'�<�Ui��"��QE�t������ݗ�p-�������Xx̊�pC`��=;�İ$�0\�-=�����:��(����4�P/�:ӵXLi�l���ҧ+D����]��
;7=�@/�Aq�3x��+��벷�Q5�K�v�2:r�Q��l>��I��檕��G��i���`x�����d:m'$��=D�>�Ԃ�U��xh&�/�	�{��9�����ģ�:l�=d�A���� ������`�] *�3��#�i.;j�]�����w���u�	i{6�$n�C�G����4��=ꭚ��R5 H"���[Y��85�_ı���ĊA~�ئp�h���U��L  T�ㅍ��n٭�k]�*���l�`a���A�?��\�i�c��n�?��b�mv���b�_�)�Ӑ�[T��c�&�*{�+�}��,Ӥ�y��~9p��wNLD�iwxF���Ar�U�3�p�G�f =ݧ=��No����Z��;AY@�z�1�rO�v���M���־��Dw�W74:�)����L�jx"���gFë�lO�Lx3V9�S$�jM����bE��c���-&�gj����g�7`I���d��71�I�
@�8��ֈ�
x>�-�`���71'Z�j��I��ֿ�#	����Hؐ��/�^�S�U9��ꁲ�<�Ra��URǂϳ��&��2����fW���-���i�/:��G���ھo�a��A�!k�;��C၁T�}�p���_�޶4 ��ll箯;��+��՜�F�1�^K�����ǰ�v�I3-�����K�b1�K��!<��c�L��KGYe��Z}��p�,,r�íFn�p��$�B��L=������q�W��8v�"�?�8��~8�}�R���C�Ҽ�b��7�������i����3vNb������#2-�t�_�=D,�~_n�\�����D��QFb�톱��n�n�t��v.����~�}�Bʁ��\�@E{ڰl�M
�ܯ\]�ϬR�K7g�n�)�Ty�ٗ�X��BȜ��>=���7�^�+G���-�O����'�_�'�WaQZ2�����b Ifm$00�A�3u7�)Y���Ox�e\a::Z��+˲�kl���@ʁ�i/�5��6d#�Me��0>i�9K%��U�_�X9�,��vt��n
ӑ?���b��hZ(���^]qtK�mۼ�=ǩW|�˞~4b��v��x��NAS��W�K�����ź/�� �B� �ܮ�l�b�w�&�I�p}��ސ.�?���z{_$�ޗ��Y��I�	�Y$P��*�F ���XK�Q��{����@�;Q�|Q'��$k?1��=-�p�(}�6� m��*���Z��V���q�;���⇋� �L{���C�{Hy�Ё��,؍���ClP��E���`9�/y���3�����WG�9�r���*��.H�qÉ�#�O�$ᗖ��.�Ρ���}�e	�A�Fp���&�2;�ٜ�&q*���.���������#��"��jN�-��J]���^�x#���gXar��0�Z�D��� ��[��T¦G�F��Sqb���'�s�_�Z�ڼ5W4~��w.�ҹ.l֎z50-��fb�eZ�N	=���_W���>�d�aL�|@�$(1/�bl&uc�7��v�J|b#v� �� �&����pD��M:�
:B~�5��n��I�k�*��������σֽB���(,��r�;X�x���#LЃ,�v�Z��1SN�sO*����$�@����{@U�9�N�m�*��56�Z��@�S�S7g�ӳ`U⁏�aE�yV#���cj`�~�G�b0��Vyx�9nJ��ƙ�sl������X\��1b��wB��g�V��]�d�ƅ=OΚ�{ו;K�[@��L��fc��VCmA������	���Z�/�Gz:�ΝOf3Ք�ڈ�J��,Ha[��/km"ΝGS���B�k�'�=����bz�q�Z,�=��"���vm�{���77��1��2Rk8��žp!��'0j�K{���,���6��|fq�,�٢��=!�v�JD	>�g\sHq�o\����-�5+#Kd9[��͒�~T��w�S����v\�X�Z�ղ|+b���0�H�ʡ���1�ێ4��Tk�Xp�� aߟa0���#���$e@���w/��5D�N�	Pޠt��jF�<�)�W��
*�*YЩl�m����'�&-�פp�l��	i�ϳ=�#���,7)���E���� %��2����D���j+���p|H9�(6|�mY�Gu�i;^f��˴��D5�y����~�Ye�� �	~T��f.��[�|�V⯞�x�bH�{[�^<
� ;�XfY�����E�J�>(j[��ה$����@�ĵڏX.��E���{�=R�{�]ybW���;~�ef�1H��߶��߷Z΅vi���v��t��t�ܴ��%��O�������sg�"[�X����4�^i���^i�y�	Y�����J�7�>��ם�f�s�#��p��yR�]�5�� ۴�:���eןyf���v#�GE�.]����)�w���Y��    �l.{y�qޞ{���!���X�	b��^8�.>3/�OQ�/���w��1TÂn�9�3�� �+<�˥����ٛS�-�V3��A���Z��e�1y���l��vV�&j���b8.�@DV�Y�2���{����ef�̛bƪS4Ĵ�-�׭�����ŭ�uI��m������H�o�Q��vU	��]U/����_J��Ol����pg?���CU��b�p6�[��1 ͽ��ZM�vm\�*���۴�����&�HBQ�Uv�081$bED�d��Ӹ�}�Oٷ�+��<��a���~wt�7��$HYX�~��b���7Ԓ��,��}iMŀa!-���*�OV�Wg���dU=��ʍ��/&J+׼<a���1�E6a�9��{��"�&�A�D��������aص�a]���b��:s�θ7\W��u\�:ځ,���zaQk5�3.m�� �X��r��Rm^�n�y�ww]�n14´#~�����#�Z����v�*���ڥ��H�a�1�G��Yl�7�4/���y���,� kz-��H�9�|Y׸�i�ac^�9�*5:3��_W6N��]�h �e���~���6Pjлb� ����~�ֶļ^��h��z.��ȿ�|�ORr�h�^"��+�g���?�R߰��A�If��?�8������\�c�I3Y�⢃��z�L�A�ҽ��n�^��ۺ٢a�X.�6|m�2aFe{H�@���VZEL� EN
����F�C�xΖ�2�s8�>�Ga�;�$����Q�q��XšoQ���jr���4�6��lhl��Q�������]����t֝r���xH,7H�ܨ���50�%(�D����	�k�g�$������4�D�U��`,���Vl��r_>��Xt3ǀ��.�0��f�}ϒ=ޮG@}�*�'��_��l�nֲ (O��/��1�]�Sq���[ �?�����t���t컅־ap�pf��2�"OűP��w?"��f�|7�;:/�-���	1�5<O��:�-�p��V�S��:/�	9�l:; �Cޞ����FOK߱��P\����d����~a ���0^��u��.=n�T�)yn�;�a�4D_��v˴>��s�-�0ւ|O����A�#Hm�xl$�����e�bA�Xt�����Hx�f�>�A��۝��0���3{�u#ng��0ό`�GF�b�gB���nr~�y&�~lk	nό�Y��#���Vx��������T^���W����{��NW���w$����X[�G��i�0W��H��!�=��2�9W�G�����*@y�̧�2�%(���^!�N�N|�����s�\:����4>��F�t�A�]L'���=&�b�蚜��k@��S�W"n����\�������`ƅV�2���'�@��M��������Q�UO�g!���x6��Q��l���~�.���f6b����
�,��)f�͍�,��L�[9�p��p��i�@^fk;S�(��x٢{kc�ā�6:��O^��Q�>�5|�1܋�Q�X���8�������np�rY��F1L����d�Q�k�<ӍԷX��F���)n������f^���"���٨ ��6$����{�y���G��x���F���cb7G���_���;Y�y�����ڨk����� H.ސ�����DҎ���+@�ey5��h �a�"�!XwV��W�}�L# c�:��Ĵ�M�U��H����I+:�O��Ni��
8�����v�N��:  $Bc�~�_���5�A=Ii$��g�Xe;���WLQ��X�������_�d�&�����h��he4q�J���A��;�Ş��`<�,ȸ:�C����\����˫��Z䃱(<��T}?��者��M(�u�G|���@�w�j�����yZ���M��=Ĕ��jr�)y��ۯQ���y]������@��	=)U��C�w�ձ���us[����Ob���ȣ�8��ظ�v�s�?wih'y�����3's/Λ�~g��'���&���w
����O�xW��ɋ�8[� ۂ9e�EmS�ԺY��;�*J�;&� )H�ֈj�a<���;FA�����!�Ǉ�OIvt1��%����ZI���55K�\16�f�ӫx9�kj���8�Mnx�Y�sA����Z�v�x��|,�y�y�����B�������{d��]�X��U�H�4�� �6�����8Ȯ޵�K�G�3�M�z�+W"���JY��X���2�m%cĊԓ3�On�*�H� ?Ȋ��F��z�Ol��
�x�
jR��埽*:|D�u;�q�6�O c��@E��E���r����
�,G���w���#:2+�m~G�PZ/g�?a>���|��|���(C;$��CP���,��눾��A�<�tB�)�ioLk�vx�	��T�l�b1�h��(P�C
E������R."������9��J�10V��(�#�X�Ш�D���}16|���a`q�\�M�P��B8z�NR��b�+*���
��\E&>��$��&
��k��>"��c�kc\��;��˄�j��e.E&Vg�6��`[�l���v�CsBۢ����@�$�A�8b��M����V|���glw�t������XV'k���3���v�/�fG
k���s���@���;�x��T�?���u�X dY�b�ޕ}Ӄ3��ߓ��D�烘� |
k���<_��|5�T�i��V�V.�����a���ke���6A�<�BY�Z��۴�w�e��8��I!z͠q�B�6��j�3OvQ�_w��L9��Jf���H^���8��`7��2^�-�`�l&3ZGX�"��^[��&��)<Q�U�E�� ���H�3�Y۴��V&,����A�-�KQ�=�e%V*�����N/�J����.xI�[�%�`��J�νGh�����B}a`�V�$�l�7P�a0�Lz�&��֐j� n� �X��z�^!��ۯ̌I�VO��M������k���`ﶡ;�lD|��,l��f咦,��ɲ�-�(+��0ow��Z�������Y�Z��(f�����Y��P��7&��	�F'Sr���L��~x�F�?t��▯�f&5$�6��E�F�{m��h�o����\������|x�ka�z�ŭ�� UE�+�)��XWԲ��[q�	iK��2�t2�AX'�A�"��yz�;�>�LQ����t�{I�W�������EM����	��|�+��]L�)`^��<�gu����x.��F�Ӄx;�"��\Q
F�D�lf�Vx���Z���|�aFFϢ;����_��'�t�?��E�G�L��F���<�B6"���Z�P�Z,�,�a���;�Z<d1���,g��-��3I�{R*�I;=�$6�g� <3��	�Sc�5g�X�PʣFl�NUpF���>U�T����=�q�o��-����6�lO��k����b2d0�N�	c�of�`?�N���<	��;m��1�����+�b���v��n���w�e(>A��þm_�o9Ķ�<Gx$�@����&��?�j9uN�]{0�ׯWJm.a�V�����9 D	��g�.I-x��S7���-a�Ά�p��߻^Q�(��`�P��6���fo���[�=h� %
c0s�5*��^òv��n%���]�=&"�t.�	��V݁0%�*͞'^��<I�}zMس�NY�;Er�$�#��`m���ox�x�V 7�G!��=r�N�#tFA��ɮae��2��:,M�Mq9-�1�mz�ov�v�D����"�Q0.n!ժA��"$��#DH�4��7=*��`���Z�[u���^U��97S����wR��OB�i�$/�Vւ�ΫS�HeZD
�<Y��	˴4KU��LUU}G�����#_�����(���G����;m^C��gC�&�B�llԐ����+��2Ӻ�cƘ��5j�@E���e&j 4z<g�*YMD�巤�    ��I��$���}�Lv�g(+_%��� e�@����O�f9��6۵��,3�K�MskU؛&.J�1+Q��+"��������T0XUߝ��$�r ��MK0�FnM@�H�A�9�)C뎪P������/"Xc����e��2�欈��K�A;��?	���x��L�/��:<���)rk���r��cRD�1к�ފRe����ȯ�-��o&�xB��]���*�̞�|���>���гdA�����/*
�A��R��ˢ�;��u��PaL�{U���u���/&�ػ�W�߄w7>��v&� pY����������z)0�w�Y��L��]�ei���[o!QK0���r�r�4[�r�jURѯ���7~z��vgq7��}ṿ�v3�J����~q*�������J�Z����X���E�Ɍ�#D͠l�x���!��z��6�ƾ�-��to�Y�����_��5�Q$�^�_�І�K��_�M�5
}M�c"�+l�c���b�� /��x/�؃��g�4��ԓOfu�fl��8�S٭�̪�̬�'5�H�����̣�z�l���e��a��,7�������<�e��!aM��Rg�%:?#q}�y�`�h|��n?o�>��ҳ�ϑ.��,~�u�`ɗ����+D4E�@�����~�|ܓ�/`H�'G�]ȟ�a�Ӄ�#���қ�E��l�g���"��!�����2�;�w)4|v�q�����W5e��[{`��&_�_���|%E�l�V۠�������~����$����Jr���H�՚Q7�j�k�f�'D����/�Ck��wA� �~'�Z&�K�yDM*�)Rc�#|��c�DS����q�O�ɡ�h�d'I�����<�Uly�s���\�zj)������q��Z:��)K5డ�P��J��y{H�� y/�i�j�EW��ԍ�{��zx-s�
����9�j��8����9���Hت\�x�ܫ+Om�x�,X㹺�-�`L��-��\=�G���u�h�k��{����Q4Vǩ
'Ww�3	S]�'>��fI"+�Ck�^������~�[g蟚䑝M�C
2���>�/�#Z6����T�S.���J$�����6{���u5��w�N�ϾVj��%W��1�aEc��h�\]Ї��fF֎��ydN�GzI�������.o�}�-�Li�^ru7������ܞnF5��ؖ�[k���*�j��\Zբ˹t\+f�����l���9|Lb@�^��q�1,����=}��o �T�f�!}���\���)*?���Z�.�Z-r�0�s���l־���+���}� tg(���>;*��Epk��S��NsSA	�b���zOFb�ֶ�l�c��cr�&e]"KIV�2Q�=d���T �N��Jw��Y�)O�J�$rU�~kyyB^�*M%h�n�X��Ӆ���]����&)����!$1`L��<%��L�3��緤!��,�5�����L<��.�[҉1L1�-�TE�!��R oKU�T�*��EK�w�/0�"H)�[S��pF�ߞ���,:ܫ��#����Z�y��ɯ�AyF10s�_%I1�딂�=�cJ��4�]����֊eQ������J���o�ɴ�n^V���3���	���9)����zxO�R�;[���Yp"�NX㿐9�Rc�\9�ʒ����֧�-��.�'>Q��� (=���s� d���˞s�[x%�������oO��[�|��P�`*�f�^�[y�n�����Y&d�DaY�e��p��+K�Sд�_}��I2�"}�bK�~gy#��W�N�WRF!��,��Qv�����z,������v����/�=%�5T|vN	}� �,w��4���v��)�M�o"��ML��L�|�$�����J�H�	.��7�n�>�ʅ+y�z�u�D�5��Ơ�}�ξA��T���sߕ���A�@�4�J�.��P��

ޒPnk�ꙝQy�g`=����=���8�֖����|(%Ŀ7+��6s �[�V^P�('�����t���%�JtU�mVxm����!/R[C�"╜����C��Te��-�#n�˪��G�aq�=�-9�R�4�7�:IK��+�;M���T0�!$�!/UI�}~���:+}Ŕ޼�9����p�{O�p�N�gTg��r�'\R�_�;�`���}��|/h�P�L��H�(��-Xz���W{;,c�	E�a�_C��Ì�%S�en�o��-��k�Qgԅ}3��T>�򨒜>��eSRV�e_�\�((q/�{��}+�^�'m3�J �;v��������9idM>�p������?��%oAP��B�����P�'��E�u�a���M"�(d΋��Z!m�Zi�]�ї���~���%�S����JU���.���e����2Ys�	��pB5B{n-�䧏CD��+�#v@
#|�*5RSD���Pe�ò2���=�a.��[���3������R��t.`Ā��L��k	�L��1��L�`�S�[��T!�qi����W�4�lg���?E���@�@�ʻR�=)P�2��X������^s�=�y��Ë8R���sa�YX�#@��/�X�0�5� ��%Rĉ.�w�lT@�z���U�|��"n� �]
�-�]j�����>o��nQ-=pF{��#nGk�v�\I���{l���7�^ĥ�����/���z��'V���l�]>�r`.Id���68��ԓX�����@�`3�ğ�t���a�1;�$���nF���Ň��|��Pm��E���_<��$�,6M54��1X6`�����,I;C�����AWx:�3oکK����-�A���W�iO�����m>��S��?(~��p���Eߴ��k�b�WQ\	�䓐{��}pTy��isJ��nwV�^NѼ�/7���Z�\��`�8����4o�^>}k��=�v�QB�'L%��*�	�W���^�z��$������骂 D�����+��]��~�1&L�/�����/1�6���P��F꽪ln�.~�1WIF��O�@�����R��P�.���庞�wGg���Z��^�}�a�Zm@�Q����K�j��N����[|l�@�c�������8�'0Z�i~�|��A���9�AAE ��,A+9��퉴s*4�qm�\���1]�Hf�P,�@!ד:@�,�f~��'����D=\�6��D���jV��tp�^��,�&�3^�{a;��_3�hP��^�>�A��}F��1�S�!}S���*��$J���ZmP_�����_$+e����B��^ߊ'�mÉ�>V�A�q4 �̋�;���⠓�-���pM�����.j�7Q�uE-��ۉv(Bd>$�����1�k��Ի�q�������X/7�^���"�i�
�j��5;eM���(G��f0� A�9�4��O9@Ϩ�*��/��f2�S�������D�*2��,��.&2��1A�A�\����Ea1(EΥ����c���r9b�e�1	m���ع��]H:��C��Q5�n��B�_H���l)
Sf�$ЕFO�zZV]4����C�Ѣ�p���n�s�V�@!֠���k���P���y�
qҮ \Ț}���Y=���ɺ�>6�����
x��M�PE��D����X���0�x��"��B�\f��h���溚�,ʾ����L�I�ߝ;���R���|���j�"?tU���B)����o�#W��?���z���R]�m���Μ���޲	���R1��#|���b��Amd�):Q������a�Qe/������<��h�v"���e��fF��b9ԟ%�������'/p���G�?Q0�S��r* *U�<��`��+͢�Ke�/:��ts��D(�^07�?�����ѡF�����æ�ܭ5u����O\�A4����/�*��߲��H��T!9.�e!�Â��a�o<��!�8����rn�2j�¢ma��L{��h�Y�    �U������0á�J�����V�,�IqOɽ�!�a�``-ő~��h �#ᚍc}�K��h�x<E-]kq��>�n~�*m�]�*���w�Q���f��(B��u�1�����}��鲞
��\��mgy�I�j�+|�ؕ�h+�6�7�C-������]6Y�G-��5qC�=w���A��U�Vp�L�۞�Ws�h�L���;Vr�h�e�5FuO+V���s��s�R-�s���P��$U��）��w��=Y�%�=Y/��b�$*���w?�v�
�ޗ�?T��l�oa�ռ�*�\������:b�2)��K��>�G�:���-5wL�D0����\V⳽��Q����z�s��NW�2��@Wּ@W2I�r.�6�C�<���=7�U�NWU��Pl����i�g$����|�m땈%Me�鄟j{I)�=e��8!(�#}A�����g�N*�\X�f�
�kS��2%k��?�?R@\*��(�y��ps��������a�pl5ۥ���jʐ�s'Z=	3r�:m�n�Y��DFJ�ʌ��%I!���JSE�9����V�$���r+�x�e�q c�j���5#S ^�$o����~�Y�B��t۲�r���o�/P����p�}��mջ�������z:�L�#���{��-�VC�j��2����N�Ф���6�e�7,k0�q�L?���j�io�=�٫S{8��7���u���;���-���&��9[�R�x_׸$���Ҵ��n�Y���_���]il�w�ۮ�~Y*9��X�ŗ� t��9�e����g�L;f֖y�; ��9?�5��<c�m��m�#6q_e�v�K���9P%�s�E!;,U�fʝ�ryb�\]|,������DT��*w�-�5���{�WVڷs!���L�p��Z�Oy�	U��Cf5!x���Q�-�m�
��tX�3~%��f���W��"Y�u�E�ï}yە���pjǈ�_��p���"@���dￃ7��/&W��>�U��w�٬r�=�sU�F���ݥ�y�)"�$���҇ז#U1E�t�m��B,�-W#�"Su�*) ���K̙��&V:5��K�k_�%����<6;�L3�He��.���T�٘R�8�V����Ʒ���
&(�B�"6|�sv���d�n�%���M�2ƳҘy�Br9}è�z<����eY�kO%��.�j�Y!,@>���-t&��H���Ta�����Ar�KIb�40w[f�1,�x)����/���m�W�t0:�F~���ʮ]d)���k���!� ��7+P� -
�;�·գ��1�y�)
%��k��1_;�U�S^�+��V	����?�;
� �_�4��tn-O�r�㞎�ۄ߭�0�<<CJ����x�=���w�
�!�S����;gM''�"��UXQ#��`u��6�y�d$�����'� ��U�2���z�B����5n[�_K�k��a�5c&�?Ml��I�hn ҁ���:�ݿ��7 �=����F��#�^iB�,����s�F*����z�[g2��뿲HGl��V��}��	V�gʍ8�ay��,���Q�_�VP���|n�,���-��͇2�u�mw�]�r�y����1L���m���,��I.P4i�I���q�����誑���VVMB��z}�t�m tq$}��?A�G�kR��{��(���d�C��|틾\�s���T��Q���|.�H���Y�v�;I��Q����_R��_4��.����n�2��x���Ğ��!6���j���N�Y�M/��2ܸ�]�i�6����<Nv��~����\`�Mv8:a����_ȓ��	uKZ��WcпG,�P�Y�o�3MR#����?@22�1��9\6y��y�]��j�=KT�gb��A^O����Gz�&9����89Bᴿ7����ſ2��]g|X�L�o{M������~гVxԝ]��:
2X����1_��6drF&,��*��%c��`�z�;ih"�{�D~�=��������������� ��=��\����`o��ߤ�k��p?�z�)5��>]���`��)	�w5Q���xslDN)�����o�s>�!p��)���}���^��pS��BӍ$8=\l�4���a�W���h<ß��}/��u�y�Y����>�[���,���c..��)O����ڃG�j�� 	�hv���Iq�
/Z�j9s~�٬�����b,I{f��d�#^B9&�wP/��W
r����'8"��U�H+�V-�Q��a��E�B-����l�A �sM�ֻ�]5��N.R���� �����8MZ2.�vN�ќ/�q�c�N���3�����e"�cyk���!{î B������������m,O9핔����=��jϖ����8�*y.��^ u�uw單.�2�>��@�P9�ʟjeb���`�Xe�ǥD^_�L<ߍ�Pef�כU	U+\ c��9�&�K85���L�m1���U-��n��c�,��bkxe�PS��T !��ߕmVǸ�x/�z�Oj�������d�,�Q"�����5��V��`*���
c�>��؋+T���d�/�s�,��f9�����_� ޶b��oqԾ�R�}� ��(;3�Zы��h*}��X!cA�kӂ�R���k�r"=�8�4����!� E$_鍹%NL��@2'E,O�&5�����$:3V	�Q%����_E�?��ɟiy�����Gp�p�?���r."B&�d�C�.�5B~/
��`����w�;O�l�HLN0��\07az`QL6�N���#ϰ�"���SMБL��lK�GD^�۠hd�Q�jX�ٌc����ۏ�/꿟w��3���گL� ��H=�M��(.�Q8+O��fJ�ǅ�9�t&�*�O�Է���Nς�I�Ɛ�h�g.�8�D�R+w7���ɦIle1�+�l�0<����� %{��r_�����#پI�;��l��ǣ�� �t��=OU]C�	y�/:��;+��V�jB��l�A�ȱ�$�~�߄U�nLGX�l.�?�WuE�?�'���f�E��.��P6��5�x)Y�gȞv���]w3��Ʊ��B K��\��m8F^���9�D� �GP�A�ͪ^[ߌ� ��p�H&#��|9EB�L�/m��_.�#�q��<A�j��Cj7`�G�i��3뛲�ꇒ�H����m���}&�Z�<�>m� ���T"8g�[�����6���ܫ�n$�!#����5���|k�{������L�'�B3��9��xM �,��t@ld<DQ|�7x7E���Q.?	�\s�����N�g[FA|.q��3�h��9��@pe���zJ�W�*��n��^�<'D�L�4'w����#��3���<ƣye��O4a
b��D�w}���蹦�k��N��4X,�S_����������0��Y�p"�j�]2X�B��j�q����\vҧv��;;�R,�~���\/sN=���{�J�e�(� �B�Q�F\1�D��'����Q�2�KP䮯����3;����'J�Qp�6v����3t)��O;�3����3��C���� �v���������&Z��3�t�]	�y~�*���+a��L�B����IZ�f>��+Uc�L��k3k+0��΋[��-z��o�b�uUP(�%HLD����~��eѝ�v�Nun>8�����H�:�����#�H[D�="T��r�Bi�{ʉ-C�.����W��	z��ɾ<��\�����s�����#�A�����^�*�FՉ�l��9-DsP݀���1���f5�Juc�uK$��'5Gps����T\���Q�BuK�y ᵘ�4�wk��	`���ߑV2� !�TW�#��̜"��쫧r��Ӂp�4�E�NX%9���eQ�]u�c�g�T�j�腿QH�-��	jr��+|r4x/�{=�ޕoĥY�/���g&NA�2��|��:ZS�����X�K�q��%��!�\g��� ��y����[jmdj-O$��l�    #8�q��UT|1�_O�ڙ��J�XnF	��SX!��=��	�2܁8Z௥����������G�Gd�7�H�-�r}G��F֕���l�&o�g�^w?��V�`�XޱE%~���]�Pґ��f�'_}u������ ��pX��,�P=��P:sUh���fl=��س�A�/D���J,U�a��r>Z����g]��bC�s�*qL��(��)�Bm��<�t1�	��Ǫy�w_xY��=o�$���P- B�R����|#W�q�髃+L���3�I_ug ��׾�&K?ν���g��d�#Q�K�z��wL��d��ŉ�Y�T]p&����Z�z"��Et	���h��u
���4���*�%�B !�$֭j=��=->���Η�v�N8��%��i��.�m�T���z9�Hq[_4�e2f@�gz��TH<��MU}O�@W���0��k���I�포��~Е�x)_����	�v�v�4����=�U���P��M��:��*��pu�4�Ԉ���|Tá����B.�$�߁w��)��-�g �QR���
1�[��=�L �~�S�Sr�X� s����$�\�΢�^�9ޮ����d/s�>��`�T��N��9"
qJ޶mMw�תS2����	,%�~	��7D2J�����Ah�x����qF���Yq�oD��l�&Xg�#<ӗRwa���n�Q�GG�4�o%01Q���-C��[]C���y�{�W���j��:�g��^!Ĉ;�8#�k��l�߯�Fe����*͚U�޵thqݸO�%7Ha�~��Yx>�ۊ�Ȃxd��a[�W���5],ŗ���喟JF����D; �-�eG<�Ώ������[���BA��@�x�>�ןt�i1F�'!@�S�@	P5�E�o�J��.D�\<����6��J %�}yO�s��C�@�wH��9�;�J��
�}�T�NAQ�y�;��Ȫ�rU�^����,�<ӁsQa̝����c��y_�����Ԓ�j��C9��\���k��9���1\����RV���y!FP��ό�[u[�H��՛
r� כ6+��?��5S��J����"�������]��0u��Om���n�lV��c���Y���4��Y�s猘΄�I�2F�]�p���,�#&f� �0݌l���=�|�j%�$\GEސ�#�5������ςW�Oc��e[[\���������N%�^��,�F�w����kwX�O�_S<��%��6+�p&�bRq�?���A%��L�q�tG��ҩ�L���-�3lp��}? ��ChG��N��Gr}D��Y״=�������%9���i����z��ןp#t&���Hҋ�ʸ����p,�Y�#������v[G�Q��ґ��Z
A�i-�m���G~�:�8�VD�#'��D�cKz}�����s��T�yᯬj$�j���:ค7�;�Fg����Z'����A�u,�C������D^`K�Q�$"g�����`k)�ID���>��'�7\�:2(�$��y�ES %�0�L���pC[l���1h"���$�U�"#��}�*s��ߓ�d�J}�X��җD��J��߷TvT�h�8�{��Ϥ(DG��eu9�0R�pzK�]�{ 8�X�ӹT]0��Ѵ�kGⅪ�$Nn(f1qD!�b�SU�Lz�h|Ly��A�d�GX���R�ݸ�	L�	���kn$o��|�V�rpㅽY5���s�y�S5�#I��ar����p:C���f�Dz`��S�Q� ]��	Y�H�q��P^�(���q���syy�pS�S��VJ����RspZ����
�ug4oˍ��=g�H``Nƻ1ˁ���u�&�R����H2L��})
����bI{vB���.i���F�ӕ�T���� /��a-\��?��O�/:wתf��T;�'o����a�bR2���wr�ٍ�e�p1-�Δ;��$�T1�T����FDa]��y���W@��慟B����݋h�u/bM)��AoD��i�(k6-���A�lu��p{��$�"��+yG��)�w�N�,����I~�|���r�c�c�Eӎc��fNe�!c ��-G�XL�{��>R棰�ng�q���+P����v�3���f�E{9+��ʟ�\H;�1�\�'XBwp|���9<��ҟ�u�X��>�9I]w(�w^"��>;.�'�t5��)9w��ю�4gG�6�X>�(�S��\���>���ڟ�6��3C�~*d��Ԉr�;��KOD��֬�Q�Ԭ�q��GM
r�B:ng���r�U�ox+�����YÜB�ʠ�ahX��퓷_hղ��!*�뮧��f"�\0���I��K����ˮc�\$��*Ѩ9���헏�>�-�T�#�@��,Q�X��{�Yt�Y�g�~=�6�`2 Α�z�]-�h���I0�Wy�rO������ Ɍx�̷�Z)��L�����巙(��M���*=�=�6��0,b�0,�\����J����Š�����ހM`8�دR����1�+ڜ(�;�^��֎qk��ThE�{Y�T]�g�9%o���J�"��g����S�{m�غu!�諔ϸW E{��v;fj���Sn� �)�������q���(zm�zA�=vN���7;����g
ri���o�2�%(��\0R&�7��b��F�i�#֑��H��3���?��Or���|T���+)�o�T�݇r�-���u��C�˯�+��s��`���]~��73lr,��o��}�I	�-?p��d
S��APM�2�piJ�S�"Q։���-"�ip�MuȨtڋL��O�P&�b����乖�]�
T2���(	��4���j���ah��$́jI{����`S��s���<~����hi��i/�}����
�Pi�N�ې>C��p��..����=q��T.��zF��į�L�ȋ;�ί�ǚ��F������x	y��$~�����l���A���0ē�'��Se�.��~��ܤ�4����ubxY�.�&��~N�_+(�&湠p������L�s��|C<�J��LG��z��8�{��m2�>ӗ�XB�+�	]z�7�i�|��'�+�yU����89<���<���ԫ��)�ƕPۑ�6�|�h��W���.��0���c��O��#-?#"G�m{�=� 󱑔��
�Sڭ�N�����|��FW�����9&Qpq���|�y�~�Kb��P[uj�n��&I�I���ӥ��g��k �xn'�Z�,I��s4�q�}�f�t4�H��{%���v+��3�;`����Y3I�}�31R�݆`|��R^Z���f���i2nȣ`����$D$�i=�+��3��l��P�	�)"mn[w+��q�(XzG4�����N��_ee�Á�
)�gcq���ߴ��Nu��,����ܚ�j��8	D�R����;XLV�W�C�����o�>����2�u�݈�E���@��D��=�H��Fp'p��q* �Z�y�X!�9u�i�R�Z���3�J�FL8��	� ��D�;�T(�U�ȝ�:7�z9QÁ� �皉�������qU&5��T��ӌ�~d�[*�Ě����,hv4Է��r(VEFV&j�REu�Y�)�>��Xb����`Y#�=�G^��!r9Ǟ��9�뮜�ٶ�MT�W8co����2i��H��o	���d�K�=K���L�b��r������r��;ٌ�s����s��XMk)c��e���R���J�����3M �ݑD
!.�Ҽ����LBlX C�G�H�Y�ؤT�׶@�`Es�"��ߑܸ��X7e��e�g~��Թ��8֕�A׶��a���G(ѓw:nǼ�hantgr�F�C7�I�Z�x:H�5��J�	_�A�I�}�56כ���b��������Zc�������{��)�7�Lc��W{"I~���p�ǰ��w�0�'�(x�}�� J��v�]��õ��B���-hj����f������1�	�4f��o��|O~}Z�,��?�-��*�L����D��fi9v<n�k�A���Ln�F   �)���� �ZNL8������qPPB�����6��e=�p?~�Sd��r�z�q��z^����0�C�+X���NH$N�pCf�s�pA��K���2�����k&�x�Z5k����Ԉ$��\�l0����:)����u�q�XIN�7��O�]���%L�|�X-�{�C��1�j]O뀔��]u�/�%��DB���%9��2�E� �q���p�R����,�kD�]2oQ�����^�� u���P�F��
�ϸ��*�&]�Sg1R3��Zن�s�*|�#��Jc�)�W��1i�\H�дm!��$.d�kEƕ�t����RF�H����nCI�v�0m�q�yvE�x����2��e���c���٢W�p���G�@�w�:	�?$Mb�pS��j��[�5��%j��^)t�\'`�l�A��ϯ�;���W�����ϯ��祔7����b4��)d2;>��)o���r�"���ۂ��2}:㗾n�)�;��Z@#���8H�l�YM�����* u�-1l��aM*� ��%=r	dq���f$Z�%^��;_W�q�wDv�T�|�B�מm�^�p4��x`�Y��Y�rf�땥�f1���NL�
;��b����n �l-D�wOܔ���--�,��fGfqi+�]�.٠Mm{�pv��t	}(֟q�ٗ[eG�����|�Ǖ[��ıN�#-G���~��IJ@�sT��vb�������%��gz�w
 ��<�پ��	�6sx��{��/������ ]      �   �	  x���[o��ǟ5�"����E�.}�ZI�D$%�~J�Y �uSt� M�7,�����jmY�
�7�9���˙�Ӈ�w�g�g.t:N�u;�ߊ���x_��}V����'���)^��u�2��l��7ŧb��^�K��ʖ����Yo�o� 1O��P���϶��7���D��%W�be*]�r u��K���Z�-)ӑ�f�Z����c��`sS�F�'�<��H�|/ن>
v:�+|.�&�)n��-��`2L�����q"@�0^���4����^�8��+K[.B����k��u��Kn>�g��8�8�v��^�M���'��nM�x��T��bx�v�8A��>��(�@��dx&9Z-UO	�uDSG��n��N����@��#W5R�q@h��]���.���åU ����}�ȤYݫY'��	�9��'�0���'�3c�)����8���f�TQ���`�ꆝ�u�R��B��-��\��<i�\#��PN����B�]�ՙ�q5)V���h�7e����qy ڙ�^q��%���}N���)\��	����F$�}������IY���?��>���d���{Ցܛz-�v��.
SmlF4φ�	*%j�`R�\o_@���J)��HNOG2�d;��������T�`�_�U��K~���(5�eM0���� �YY�Jۛ�0V��<+Y�C/)Ϩ�Ί�f�}�e�w3%\�n^�Q����i2or�2=!\�]���f7;���QfAE	,���p^��.������<�ss0�Ƹ23Q*�89���n8U]�bZs���2)�(�Q�`a�*3��#	+[�֭�,�h�q��D�wkd����v�^�FR�\����T��H ���]B�&'�8�OT�T[R��hz�*>��U)V[>�rl�*�+ӕ3���-��D�?]o���r(ϰõiN�%��5��11�UL�5�/��K�E7��.��܂�&m�8#�h�>�=���[�_�����i�1фY�FFt��{`���^^����ھ,��� �bp�クZ�3��ʍ.��^[sA�j�x�x���U�������8V�\Kے����S{C��l���p����m8�Ō�{{{�
 �&�5I��Պͤ�b��!�^k�O�����Z3MR��.fR�5m_�ʴ�b�%� �aV�'��"�����i$@उ����a>�!�~O��_�_)˂9�/�����r�	���tRYr>H������^V�6zt�=�{ܹ 7ܰ3�j)�e�'��=[���bz��2%V#q�E�P�s�k0eU}�*�T�4t�
�Cy���c*�Qr�E�Q�ҶF�f�J��6S���r���eY):����+h�����.ʵN:ʂ�WR�HY�OA��DTjiUp�/�C��l"���@%�ˋ�2�#�VH��\�Oټp&��,ǩp�İ��
kT!<��@!�5-E�C�.�O۾��űm����jq�Go�)����k&�e����8�e����V�Z�;��VE���3���ƪ.�U�y`�O�*ozC3�r������� ��T*�.=�j������XwD����g�|�e���hU���'������=������5�YuH�h���<��T��&����2��k'��F�BQ�>���J?t���Ż��c�ة��\D�B�*����G�uT&�#���cw�w����I6��q�4����S;*?���={�ܛu�R.s��~�66S	���	��	U�` �~���|6W�́��\�� -�9Q���tK{������/#e4"Y5F��]��u�C&M���M��$���^�+���^�Dz!/��j +�@����]_�у5+i#�IpY�9Y&B��a�$��CG�YРܭ#��y_O`�֖/E�&b�ў�h�u++
��zV�V���:?��;/u��2�8T%�D� ��]��a�o���t�ӼVNh� xX�B�n�o�d�d2��߄y�&Fh�.6'y�G�:��Q��%�rHB�49O&�j�kt5WY����	1E��|оg&��>��&ʵ��!%�d�3h�i��� �C� ]�15@��;bՖ��6���М���	�] �?�~�j(�ai\�X)�r����}�'蚡g$��w+� /JO����Ы�(?�|~�~,Q!i*3�����U����$:��!����}��h�A��l(bp�r.X~����ve(�F}�izGT]
=���=<��#:%���~�n:����i4�3'Mm�8���bs"b������������M
���.��(�!l(��D��}Q��*���#��Q|!���d�-E��V�+\�U��k��=����ߌ�h��@&�^X򸓹�R{:�E	}JV��]�h�{t�{��k�)n���Bp�]H:�UT��'Q�`�H���>ޡ�@[�Q�j�YQ��Q��Ɨ%��'!�� (��      �   '   x� ��1	Легковые	car
\.


�      �   �   x��M�0F�3�1��ø)�HbÏk�W��b�0��S��{���zzQK�2).y��M2�ƕ��}P�� �,�ȗ1������z[q���T]d��7.�e<+��?'�h�[��6�C\j��y�Bg+�4r��@��:'���#'�*D��3d[      �     x�EV�n�F<��
�@
��(���q��n˨����"W�F$W�%%K��9��@S 
�?�-��o���om����Y.���}t�"u�6^+��b��.\i��,��z2��_*D}8��2�]�w�}m+vy0-e@	f��*�@C}v�f�F�/��l���Tua�j�1E�0�-
��Ԩٽ�(�T�뺶j�1E��6]��H*?�/өJoE(�p��\W*혢���o�b�(錵w��av���L�m(�g�!Ρ��3|׎)B������k��tA1�锟`�8�l�cDq,�]�:4lv��^g���c��b�|��b�92��N��Bŉ�~���]a����e�Q��U>7U�^'(F��:/�2@�!����������x��U󎩇�V�j�@��Ò��Q�;��9�2��cF��Gg�*/S��G�[��7�2����7ӱᨏq�z�J��!���G�'zn�Z ��aK�#�{b�u�#��blj�5 ��We�H}T|Ҕ%�\Qu�l��uS�?�液�����>��u��t�2�e=]���<ͮQHdxrp�^����':o��1�H�Ę�z�@������?�}j�`�\-�%��T�3��ץ�o�C���!�:+�����lg�>X� yN�uT�N��e�$�J]K�d9u5�)A���߲*�(A�3����[A�@��L�v�)I���k*�� �Yz�=߰L0%�qf|j2pGک�n�}iG�����;E�1������F2�s8�a�N�0��rK�M��!��`C�gR	�ٞY(���s�����le
�h�d皻�U+!"۹i� �j�1���ؖ��ju+h�D箪-7�U�4���{l
��νΕ���B���@!Ʌ�tS��wL��7so�KnP���4tc!Յ+����m��{��F�Lbku�j�����*�y��M����@����Wl�h�D��r�Hc��,o� �1�L��RHcd����_pTx-�t˒�4if�7*�x ֮YZ�h��/M(���4Fї�	�U��_����"!��]��;���I�����ڱ��ks��=$���cT���
�����m��rW�6�#���j��H���\��B�ܼn�޼k�����7?�_������A�g�/Ay+�G����ۛ����������}�~P�����b��@����Wew"M�����w~U�|�ۏ7oeU��2�h�:ߴ����/7�T��rm��A��O��߲��ݯK����m~����9���      �   ?   x�3�4估��֋�^�ra�vr���p���_� .JM,�2�����0W� lE�      �   r   x��M
@P���Q�vc��ҋ(ɘ���A��5��#�����'̘�P�*��\q�ŉ/)]�����.r��؁R��Ca;��mo;|��7uő+6)V�;eF�&��c�4H8      �      x�|��v�ʲ%����[�3T�xՓ���,ٲ����HB,��P��8�R�R_VsFD��׮;led�2��D"��|�;���Q��郷h_G��.��r=�$�����֯�XKۮ\5�W�%�^��r���"F� ���]i�l��(�����,_G���b�[�ߟH�d���x�5�X*�k]o�ˆ����]yTc+<�N�yՎ�Z���;w�
a�Q̿��[1��(�X1��(�������Њ9�FA��$��(����o$RC���3/Z��Q��(��dg^��Z���c1��7e���fG���CS�͙�B���j��
o%b���:Ù�Z�wު���Qz�Z����6�I�j���jY6^+bj�]�~�j�U9
iF���m�ZS������(�5�3`�OFQ`EE�VPFQ��Л�#7"o�x�X��y<�1c!���(ʴ�z�tim>d�<�V�ܛ�X�q�{k-�o�b��9j�Dc��y�-�Q�u8��e4��籷�G���.�pE�5���1��Ԭ�Z�l��OX��;mq$���n7u�-D��@��z��6"F	k{���W4���"�mWo��E�U[l��F
�$���ն켅��X��<K�$5 E9%�s�Q�[q�b;J'R�*V�vYxk����۶<IS�1Jo�L^#b�������R�����W��b�Q��}�.p��5f/
���iv�Jx�Q�F�W��"F����X]����4�L�7�&RPX��4C!�B>��QJ���e���]�t�b�xֺ�(�U!��`�%Z�"e��gż��5U��0�2�0�v8ܶZpyE4�'V�5���}�u�.�̠�A��wʧt��03�����+�Qn���ƃ�S�0�07��HF�Y�����?k�:e�a�jh^I�"��tX�tP9��ȼ"C��֝y�S�f�~Yy j������D��Ǣ>��Z�=�~(���C�W����=�~��4Q��ޯ%��{��B�|��w�s��k�o3��V`�1��M6�m��C�Mwo��o%N�{��S�Rl�1�״3��O#�r��ǂz��L'����2�v��`b\>|W�Z`��������&@���I��߷�7
����ȶ��&P�������kqd������:�R���I�QXɪy�P��A�OYi��c��9>ڳ�	�C�Y�t�Oh����}C��&2�3�Ź�}8�[�ݑY�ӻ���]ww^�}E���v�;�Q��)��J$g�T�(=`��v����f��s��v��x���6�-�~��7�Z���cΗp�<��MU�ȴ�	8&80�3>]t�K9����{�Y!�x$���W�b��� ��~��/BW��P�숱m�
J�fSt$�2~��E��$�I��1������y?�^ⶖ�1�[K�[ӣ�������Q����q�'���{��o�Շg�f�#���H��*�4b�7U��(�?�o�;M��^�ކ�j�u�mpI��ױ��5�j]�o�+=��=�ޫ����!�^�M��"RnS��y��f�uy��Wl3Ӻ<$�+��i]R��t�u��{��C�u�z��f�u�y�ܦ��G��>�x2�ÿϽ����d���{���k)��	gP��G6�|-%�#j#A
J����H��R�=b���~É��X,���[qˉ�o�mi��w���;�_���<w��������/+!fAL��z�&ZS��W��i�e4Z� *���+���P"�}[��g0qϬ�7! �'�7u���x٢��`Sa��-���`����3��0�$:ɽ�j��y%S4�'����v���^��<��/��~��m�m,F��kr^�o��r�_H/��B�@{&ާ ��'$�b�bB�@�B׾��R+��Hp¢\=��&(އ����{/l�K��}أa�U�\%�@�������B�P������Ro����s� c���}��-T�H���.��K�*A�=Q7��<A$|U�5uۖh�-$*7��"@`OMK9
$<!�_��Z%_���yF@Pn���C1�PTᶨ��I� B#�N��)�ȁ�e��R�[0.�|p[�T��hT�0�Y�)���fA�'��okT�kU�0_ܕMS�^��x"�N�0/�0$X��j���|�z�z*6�h$*P�XVkx!�f@���h�B����[t��%�`
��K8/ﱩ�[�/� R#���L����n�e핖eV]\��cb��]�m��2�̾�uYv��z���r �©��k]mb�oz���+ �l�구^l�=��R����WQ�:`
�?�"o|6�jѲL�`gӐPH�@b�,��ۢ�p�5" K�cw���Y&9 l׹<�@{��p�� �@��,�Uvc��dA�F5M�^�����wyy��r]�<�	��};�'�R�䠂!ŚΙa֜=��M0h�%�ˢh����%���˘�=�<9S���.���܋����4��T�U�!����>ﰰ*33�O�S��ׯd�҉��;��3m��;�f�]�Z��`�u��po��!�ÕEC"6�%���*$��n�Yw�o_ċg�l���l`
07����@��/�������@��d�-@�B��;n^s�C�ϊM��/D ��k�E	\$��'���"D�T���e@�F����ˁ4�q2�4�}�r ��z��|�Q8�8x�7��e@��j�j�����K�u��(�f��)@����M��]�Z�@�.v�G��=�.~����*A��h�.�.�Y~�kʶ�J� ��O�n���f�f�gD��«D 6[��E�``�D��m�F
Ь��o�X� lv^�`���F`���9�a
�,�F�U�-��p�P0KѴ@�"��¯<S�<MB�l���Wx<mE���,��0(��Z%��|��F
���1�?`�M�5�#��ˁ4�;y23;t��Y7��zm�f���ES<v^�r Ͷ�~���F,�l�+��"Fa8q�S��:S�f�]S,��DW	"�jmmǼ]�a�
�QVgPQO��9����ѱ���2���{��J܉D�0��y�^���f�}���������?���tj0��}ԡ3h�O&gL���f�*t�Լ�k�D,*2�jm�c�k�K^֚��'�cՔ�,bd��y�v�-U�Ȕ`�|9����j<�ŗ�-A)W��ۮ�տ�JɌ��,�*�
���r6g������[?��y�k	�m):��~��]7<%���ٛdA�n�E��{��2��7M���۩a~���W���B���Ӣ)����2��Sެ�+a"A��S�\�F�r&f�]�{����{����P`�P1/�Wm�&�������;e^pv���8}�xfk䄶z٬Q��ǸJ�z���L�xv���^'�p7�#/�om��夔��(yIj�"�B�j��P���5nB1�!��+�O�F�|VX
Q�p�#ٶ5��fA�}g��"Wl.n.�Ί���@f=yE|(�~��a��������vv�9���HPt�g�"C��Z�R����Yy>�e�e�" 0<K`U2� R f	��rj�*Gan6�5=0T/롹����~��	�S�� �	�397۾��W�?7���+�AH �ex���ݜ�!�o�-.��l}(�]Ux�" ����+���+�{e:�&��*doe41+<x�(�u��)��BC+��S�����x��3oGK�c���^� �(|U/Woޚ)�ԁ+<)�Lfp|��[��y$1PO��La��~7�$.��O���7/�ȩ<�x4D��@��E��U	"4b�+o��x��5[�@�|v�>�v]��H�U� ���=�}0U�*:-����4|�A �>/J4��E:@��h�"�+x��hj)p`�Q����<x� �?0�>�ɏ3i%�Y��Xðg� ͮ/u#�ڳJf۟�hd�8D�Q`�]�8`8k��(�8��B�    �@ 6��ڠS) �w�H�}_�W\<[� ����3
��<���ى lV��v)-xj�f�D��R�e��zQh��U����]wu��v��Y�w�m���x�-J,�؛��Y�`h���1_aP�Q��)�x ���H�f���B2PH�K�
(O>�z���K@�en@���knO�����h��i{6H4Vlp6�v8����d��=�b`�DtD����	�A�TfK�l"��X�v�-����u���N�EžhSl�������Ʌe@��p%���e�T3��`/�Oˍ�d�H�ډ�Q��C�)@�=;[L����u�(�)�h ��q�B�I<$��P�Ή��p^K�w)��}�ݒ��Qb�^�v�ǕL����z]��E��t�����(�Y*����\��^vQ������Y�f���g�yOLFp����R�ٓ�U����4:�`�_��ܗJ����T�T6*Ad�x���f�u9�x�1�23��Z���ϟ���f.��w$�L�/e����	<+^�0��uV/j�"ldAG��_S%�V"Pyp�[��͒?ȱ?A0�k�X�Z:P���|>��FP�*w�U�
���!}{��`ts�
��sWH9us�'�z��B������#�e
�P���3:�WE��5���c_��r�m�4O}��1W�����+7o��WL�n����=���f��~�fN#bO��i�0tmE 6��^d��x8x�F`+��:�#'i+��x�.����$vж��)�d �/^K%f�k	�,��y��x'p6��_p�)5{��O�#�j��;�5��7���tH ��wM�x��D 6���a�~#d?�[��L������ޚ bm���ڰi�T	"Q�_3�w����b�[h�$b�"l�k��m� �+�g%f��hG�����%A_�z{r����bQ�_�����fX�� �ѕW� )|V���ox,P ����Z�[Yh�0:1�zd��`��@�bv" g
O��]Ƿ.*A��);��<m��Xõ�u5�^_� |G4��=%����b�֭-�,谧�%"#�:�b�ؑ�\�	(p����Xj�m��5� 3�x� Y�a��!j�޼��Q��֘4�%錌��vő�����I� �r	q7�n �݇N�82�����m�4�o݈ �:x��3��;�c:�}B ��p�=ۨ�űY<�JġOcM	�w�q7P����/L�}�A�����N��#���d���n�w[-��	�D�)N�6� �r�X�d-���C{e�;ؚ��+���)��������� C$��`$�B�N�|:�}�rV�q�%���l;��8p���<�>�?ҁBJ��X�!;(�fTHUA��{��V��z���<��{,~����n��HFqjv�a���2j@j>��Q5�pĩ��>�^p�J�~}��f�}ձ���Y�	�� p�@j �� d
0�����3�$n���*Ɏb�����Hۇ�DUJ���=ݕ|t������q���٪����v6�v�����T Oz�X�W;�O��J�	�����5��[F�,n88^�P3/�y��/+6�k�Y�٣�����	�b���I%�sgm_Źy3����l�e�r%(�Oy��>t}���b�^�/9ԡ���٣�b���n��V�����"Ԣ������������ޏH �'/�y��ΐ��.q�=���;�R���w.���Q21/\"*}D8�L��wg��^:�E�f��{U�����db���MW?2�޹H�O<]l-���
P1K�J�v�M���˂���0b3�X�T��Yw�&�	��@� �P�����b����U���dfk�C!���w���Ø��`����8\�Dj$���L&���Ƴj�k_r�;��<������7K��|����������E
��=�/�%�R`��*:�	��A�q�U�0K/���kR��2�����z-�-ʬ�����i���l�����n�1�f-����" ��W���2%�ً�Nɦl#��{�_w�n]p0�d@��7��q3:�]�;�YLB�X+m�����9��294��� lv�Vݦ�C)@�l���.S�f״\V��kE��h��Jψ�2�̾iUnq�1h�M�j�o�*�(t`S,	jh[d�ݕ�]�K��YwW��շ�̺���W�ج�Α=��D,����L�e�wZ�:����%������mf!�������o~�n�D?%�8xl��EC8T�Lt��A:�`l �WD�2�D��� N85����}��6�4Bf/V�Z�j�^���+]dޓ2����%��~�ؽd�$f7���t`/�$�aل�f��K��.�*A����}��\d��N�NY�����拝�2��������~�Qq��@f�%��i(5K/ٙ�	d�^�E���4ʬ��-|M����{Y񙁛R)�祑�_���vٔK�/��IP1�/��+���I���z�0��)�t �[���C�fCjzgݝ:��f��_�a�,���$y�e~�COn�zd��zCP��r ��{9��{=�����X�o�J`��7[^�+� ��V�\.�Ɠ��$K�
���?�C�%(���$3�?s�DŁIn�~em�W�ln��]E���4�	 ���k�5S�f�5ǁp`��2����Ypl�F%����EF�@ 6��p9��� ̢o�MU7Z_�릩�|��t�N̲���H:1�ni�7" �}S�r+7�tbNq���a�Jf%n��x'� l2��8(�����Q'p�Í�f�]���S	"wĆ�z��ԟ8����h�i����*�y�S�;�`��I@���-j�uZf'%�P�P��7=)B�|s׶h�w*A�w���K��e@�wby�)�<�[�T�i�G��cBD�Ȕ��o�f�:� r%��7����Q�qU�rt26-���Y�}�Pu��/�/�H�
~�>�V��H������Y� c��#c�V���f����S��	�T�>UƆ�����畆f�����:��"a޽��n�S	�lD��M����9D�j4�z�.p�`
0V�싇;�H*�.6r�_��^�y��d��Y�Ƞ�+�>�xܯR�������R�R���{�1��*�>�%�j� (�5�L�ʽ0�̸�/�vD�+ZW���z���L��υW3h�w�Re�G<EW�@n 2��Q p�]���9*�0��TC�ܛ>�+�V�P�?G�>�%gu�C"̀��:/��\�v��%ℊC�) �
D0ލ�.�k<K���Ft���wt�)�| �9x���S8J�������Q8n�E����6�����2�oŷ�LV	"v.J�lqI&f=�Ԓ�)?�O��H�,���3�0��콯�e�:^��{���Q��͸Ǳ;��b��H�b�G�M����v�ֿځ��V+�����s`)R�b[��
�B�����Õ"�
�Ŧ¥�(pn0����'	� �@��@�l>�@`/���C��%����ϧľ�L%�!�zO��9,f�.z	mX̽�E�/Z��N	Z |��z� r��=W9J%x���Gk� ��ح�F(0��=I%�A�t��x:P ���͠e�o�<+���HQ}`Z�	n*���pR�J�PK���STӲQZ�>%K�:��<�0HT�7P��(� � {�L��5g@�WHv�f��i���GW�J�o-_�LF�r̒r0S0e���;̀2?}���C-�*A�g>�N���=��S61��~��3��>���������`0 [�ñ��p�f=:�cs��ё�탣�W����G�K1�O�
6l@5l�@�C�~Lu�[��ώ�*�W��!�����蠜�(����`���W8����q�;��A:O��_6��=�(�ۓ{4�O^ E=�@^
�4^���^5C��ײ �5~�y���G�|h����3s�ـnz��|@j�ˍ�Мq�     l[q
`s�Ųz��G�C3�b]n�-�*A��x�f�Jf�e�.<j�=0>e��Y���,L��$�i�ڝ��S"���0܎��g>��z�C�'��Xʣz�? ���o*
�*�]�\�F�<�(oI�ۋ��e*�5�Yd��ȁrl/�y�ܧ��m0�a>�D��F�����R	"�	�u�{vOq<CX�G�x���f�O�敿x��)7�8t��;�w�ֱ���2���xUH\�i��!�f��dY���81YlV_U��H �h|��>>["7����^��K;1k��fYb�]�󊽵� �#�N��)���_��=x�ټ�&�8�/�����D�OT9��)�,O��Y�<������4JrG}�z�ޢJ�ā߻=��c�;�����_�Bq�7�YjF��޲���d��W�aF~k�'� j��ƛ���pB%���j��4�n�r�_�'D$�������8g�d ��dJf�-ڱ��kD 6�n9pL�N�i�NO���ff�4�8��)@�s�w=m,��8�˯6(uPB���̶i�a-S�fן�E��l�v��Cvr�\d8�p�lع88��@F`�����G�u���ňw����%H�d�P
�f�}���^�L��.�Z���P0k���r��0h��W�����r����Q0�~�����˹�q���k˓?�N�\#����\c��F������l��X�I��iW� �,ߍr�w���8,	�ܠ��L��)G�Fk����8?/C�4^Ke:�r����}t`��=�� C��r���V�� R�����}��s��6�Jf��x���w�k�Vg��Yx�(9$�(̾��kk�HYY�Y��ܖ-;pU����mw�<�R���)���ga�=�g���!���E��PK�Ժ�)_����Tʽ}��(��'���Oo�����'��<4oT8��`>��'�0�+����Y!� ��b�	 ��s��~yS�fQ��m���S�L e�cI Y����g~��GV�+=1�y���i���̆+G��R`��h2��p�ன8��p��W�,�C|���<2�����%��-�d�[��q�J	Jf��Ko����ySo߼@���ډ���&v�ϸج�ϡ����턶E[˩��@ ��@uS����Ӆ������&�▟�P�H!�;�c��Naw�ƙ�K40���y�N>���ÿ<1H�ꢰ�Ud@����}��J惻���N`��n�h�.p��v�VF���{_�k����2�G�.8��d@�=����)@�����BQ,ͼ���� ��F8���R�~R�W��7�6L�
]�O��Q���Ӹ�RB�i⠈Z�R���k��U#�����wū7���2��G�l�}e�R �Sf����&Y� \����_��)V߿��8o���bQfu�F=6R��5���m���Oz��s���M���N�s�F��5��r��5��M� �z�>q����;~�K~b5����Cs��w�ݿV��8~�����Uґ��7,��-�Xz,!���&����}�����s��/�1&�Ͻs��Xr��T���`Ôh����P+�x��bЈt�c-���!S����=>�}�7)!��B-�`J44�]��%{ar�����̺I�A쵪7^��h��܁ʎ�["ɤƠ�қ�$�)sVoؽ������� k]6�DB���ns)�6����G8�D��K�*�Q����e��>d�g��S�,��k(�����Zy�;�J2f�e��.�<%��c��po\� n�V��yE�f�j�#�=� nv~>��(��cL����7���-9�%���ZV�DF�75���m�,��|���[�sWᚼY{S���ٿ+f[>����7���mĳ!n��|�K����kr�K���i�����#:L����xT"��Z�A�	SKdک$cVߗO��{AN߉�5�]���A<�hrT/��hv�@���x?9��%,�����[7[�+�ˉ����AXN���N%�@y�{��rhe�yt"A�:c�D�	����1�$�\��0z.O��4�T�K�{<s8{T��/�x��gկ�����*V{�?E����~��H8A�/�ʊY�#*��{�~�J��}��^y6$f��_��O�SW�z�+���z���z��C�q�~���ጽ���F��X�Y�gw��WI&P�F��-� ���C���,w�O$�"�$�F�m��L��#h���$�(s�&Ԋ�o�eȥ���!!<%~[���"�'��	�\�2�i.Û���#Dk�
�)QߡMS
.�L��*��*Ʉ�i���B��9�͚�d��='�,*�$�,��,��7�V�b�_r��ĳ!>��(���3��0��.�_È��f?����!%j��	���"���llKK���}��?v��9��˒7�/�T���,ￊQ����8�懿jN+��)Q����=�s�Nr�ŗ�{��$7˿��s�y���/����l�~ɽ�e���{�h��:a6���C�n͔��u]���J�1�9��~*��C
��a �I�$c}���{b�|�U<f��ûjS���ӟ��c��L�3�u�m�p�s����}Sw��"��9��6�!�"�G�������:7�]S�����a���wk���eș��k6� n��-޼�x#b>N���d܂�$=��f�m�a¬y�����J{G���t��:7�)�|�A<r������f����Z�D�V�\9�X%��1{~���ڛ�:$��i���1�|8�jkΎn6O�JFɵ*ɘ՜\����f�}�]�ݹeL��t�Z��)Q�Ϭ�|�3���{�+�dJ4Q��,�z�E�c�1�[@���!@���FK�P�Ufv�(&u�ݩ$#v%^O8	B�ר)������cĮ���ˑ���ه�œ���X�󪐡�"�'�_�;�-EOg�!"�Z:�!�)�i��O*���|ne�Jg��(�WѠ��胂��Ul�`Z=1�^��0O\]���[of����^���Q�����S��%���eɛnK���VZ��y�_�C�����W�v�aCp�{�z�y��ɵ�~)v;�^E�9�'�������̔h��L3�8�2����:}6�}��Z�M��͓Tr�d��؋�bU-ǡ� �(~��8S�i��3�A�l���{Ub6�{�V���M%�"0;�����h��O��^]Z�\`\�.X�ᔴ��V'�?��\�ԌT��fm~��>K>V^>��1d�p#�|����5�{�H��1�x��ˡ����?���C����?��Kv�_�p5�r���	�����x�"��s�N�h,h,h��PtCՍ�²��C�E;�Q�r�[N�8_z�v�H,s��� ��8�������n+�[�Ч��\�lD����d#�n$��PP1$�{4�ـc�r��h'��|��ЬGSASA��O4��{��O\d�L�L'U�$��\0ҕ>��ܡK�����).�wD=�~��q�ǲ�X���3��S��R�P��'�Ś��e�rt�q��)�m�f������l���ܶov^]�z�ǂ�Yx%{[�����^��֩�M{444�W
s4?w�Է�����0�8��:�xbx0į���g��xY�FbOХ�<�A��h����|��5;�>��ھ�d�SXq����p2@��=��y{�3�Y��-7�r:�[n��h�>),[�{<m�Gh�j�W�0�qXX,3���-y�����Mz4T���Ja����I�_#�u�x��^�Q4į��-��S�Jk^��F��y�=
�57+�%�wo�7�{�5�5��R&\��|�u�;Q_�3�m�ߠ�-�L����z+8i1%�P���NDa;A7"�ǆ��FsgÔh��T�2.�י����y�"�g���_:�uzr"��n}��������ɑ��TE'a�H2�2���Y�^���P��ג��_4���>I&6f�K��D��     _�y2���g�[����)�ȽTUE63�˙�y�}S�.A�@�m	��v����w��W"�C~ �Oͺ�ž��m����q/�J|�u9�f`�㰙M���hA�5�(����w�����t��<�D9�?R� ��o�]1�z�df���ĸN
S2%��Z��H�DE�j�˱fJ4TT��Im�.4��Å^<F'o<k)��ʤ��{/�mv/D�N�E��*�F^��96�tV��b�yUsJnv��yj�1\�L�8�񩚯+o%��o8�C]uJ:�t�)���נ���:幱n���R;:�94�J'�VI&V�_�]�SV3����,�,|Y��<bˤ��}�V�N��t�o���.�����r�=!�rW�>\��,�Z�.��l�nT��Q>��H�g����GΘ,��=v��X��K��T�0��L��N�P�N�Pu"��SKYw~���9\NG��Nt��N?��Aӽt����G���y�t����f|����
-̊�z͏��u�G?>��m��}�҂%j%h��ǃ
�I�u�<G��)5,Q+;֚.<��V����_K��3�n��?N�=>꺂�'�f��=o>{?q�
̧�t�V�_'W��2��jљ׉;�u�u��?4��훒�����SǾ�j�w�N���>?�8�~�3.Ȇ������4�H�|��瓪��Igs��a�\�B�q���"t��;��@�	��:�{"�+�ێ�J2�3v�gJi��h�:��PK�NK�:��@q�.���P7=ֵwܦ�Ύ0sZ<��Y�Ϟ�X<�y��d=Y]N���묩�򒂂�y��W��U��(챈,������q���x��ˈe��ˉ��M���%S�f��c���X2��E����NOG�'�w��|v�Y�8���<��C��V)ߨm������)Q���崎+�㌎d�!�l�l:d㞍�͆lֳ�����3Vyw�&�#9L�Ί�j�p��"�e�N0��;T�Â�:�<��k<~桒LtČO���+�
)R/>��Zֽ��:��@cj�R���w�$=���i�="Ɏ5���oǼ|�.*.pVp���R�P��V����Ok�kO��w��u}��y�36��y&�ݛ�l��I���_��:�gH��>���� DY���u�{��,	��T	�·�x�Ax������x�)���b��C����u�2ߎ����ݡ��_��f��N��/\l���~bQ�g7�u�}��f-%7u�������Ih�j3y�e�м{��U;.������;��i��۱���v�+�Õ���bW���R3Ȳ��u�/fu��w{�K��a��\NN֒#f޼.ޗ"tă*�gLq����^�}�р���W�x�'��ޟ'C����m�,��8�vÔh�PN��!˖!g��)$��������+�X��_��XH,豘��um`	���و�p�fc���xS6�˯�[y����ԛb��w˔dR��~ʶSI&;bƮ�e�����Ӽ.��꠸�"����z]�J2�;�p�[>�~A�G���ѸE�k�Y��9�]�l|`��m	_��g�>�#��2"i$"�\�/�W��+��.�7F� �-�\���kD.�T�7���&r��z+o�o����(hm8A���鮒^+��wU���L���jΉ�;�dR�0��8:r��=�����~���f'�+�g��͕ɍ�Ɉ8���DE�x�JB,T���yi�z7����؅j�6��,ш:�NOdнW��X{2�1���ج�%�� ���b~�E�̙1��ѸYVO)d����@��և_�;��C�4�&��k=�[��/=�|`c�N{�=����c��h����G>:;V;rǝ����x��3�b����;��a����5���U~9�K_��W�رӞ=x%6�\�90���T.�V&hb������es�Kl~�5���|��q�Eb^������%���z���$t엞=؞D��_/�
ܽnfN�o]z@4�c\`�.2��>�����m�/�=�gp'+��D� Q��ؽ(�8TF�t��'����H�=��25���}4z�����U������R���{��m,C.��j�T�U&���`{�1�����d��̨/C�t��]��Ql����i�7��!:��jP)��y��?�l,C�<3-��`�)Q��]�+޽�)Q���,�"��u��.T���Y�����~x]V ���_���uM�����m*�������z||ň��Ąn�8�\��V~�8V�I���Y�i�z�u����n��=1%�+�W����������	df��Md���)��o9��t�`߶��ϰ}]r ������s��LWH'�)�ѥp��}#0�7�� p7㬯� 9�I�|':4MW s4���K�> |%���T�*�*�H<��GS����@�ٌ垳(������������}]z@y��PI&>b�rg��k����i�8�e�ӵ�:=`���"�����,�c�G(�?\�'��Dl���y9G�^qh�f���[sj����Ne]���_p�9�_��X���|x�C��||�c��oܐ�HVW7 _�C$��Kːˎ9��{���[m9��R%��y��߉vh޺X����$16���6ř����]�Ss�t��n
�`���׵�~�js g�~��"wr���U~YH�lڳ��Ҟ�Ղ|��63�󉽝ѕ�S_�s^��Wx�%ir�g�e���Z���Z'�R�"��C|�&��3���k�L^NE&��u���jN��s62�p�B���=2�\�}�;�4_\�ۚ�
f>����N���7�d��9f�q��f�R�����5�t���.�ׅ�����'O�nx���1=�8:����ʎ���uSrG>6������G9I�J<�G?�����/�r�������TJ̛��uuq��ɪ��o���.� �CC�22DWm �N�u�Xt��5�G�j /ê"�����:�R�]����ިloL�c�rib�S�}9���c^j��N'���f^��,P�?ҹx��c�a����g��:��8�#<����_��4:�=�r���H���|֧���Z�Zqw����uq�Tt��+/�ׯ9�Л,F���L���r�ˢK��!>F����u,P'�̍��	�����F����"�#aͦ��&�����0R�XP#9�8�r��:��KKH���9%sn��ߚ��,?b�ͽ��ս�*�r@��6���@� ^m�d�VqsԷ}g�k�#kκ)~ꇝ?�.y4���7�f�����~[Ս��)%j%GZ���yz�qt�Tv,P';�Q��N���x�8.7�u
�M��a�����x�_W� ^���Vt�S���^�"Z�i�SR�CI&v�K���E7�g����	�w�L�s�A�9%�D!�'E��+�/�ݒ�\�Q���U��H����H\讼�B\-\��ʒj*Ʉ�N��'.x�+�.��?���l��\r̍��wSNa�[��J\�.��>ԯ:l��e���綠
�򃖮��@4q��]#����G�B�;�C�e��|ۡkW��n��Bxr�Y�'��<R/T=<��v_1%��U�&��xOƪ4[;p�r4��r�~r�Y�N*2��S¥�܁6�����\�Oզz��'�5b璎'��4�'-3�|�8ښ�����0���qM6b�k~�-��6���?]���z�臨"���55.o�A���?�ӵ/��q��)�̡�U)Q���|,s{uhVqv/_� �Y�;���#j6��ȿ�eˑ����)�{��vj��d2���t��T�j��.}�SlH6A�i+z���P�����ׁ�:3$���rE�x`�NTc�߅�`�N�7,%�*(vz�Kw�C���ǖ-g���F=+��.���_(n���}%N�)z�3;t����F>�A<��=�����������Z��U0�7޹
��Ù�}]	����]�
ݾ.�a8��������$U�B�q��%���r�x)��~vW��!��"0    4?F�:�0���U�1�|���6/�rK�pq˼�sˀK'�C5�ɩ0^S���ӷ������J����z\{EwdS��Y1�/���DJ#�/x��f|��ƐӘ�Z����IrEO�����*9[��ّ�u�J_���<����d���e��mf��<͛�?��e]���TI�9U/|���خe�]��ܺ�I��J2�KGˠ�����/�s��Ϲ�7�,;`c$��������SO��ܬ>^����7D��?���֒l|[�Nb��������rβ�x^�m�F�MA�,<�k���"������{�r�d�"V]��;cgJn�^�^�*���ۜ���:�u��-�a� ǀ����;y���ZW�� n_��Ж_�E�$c�X�=j�z�ˆ_�W��!g޸�C�QJ�R�a�\�ȻI�|]�C4~V�~V���wN��@$��G���[� �O��^OJ���Kw4��CU���;R7����f�YtQ4َy���ɭ��Nh�o^����T��t�7o�b��o�w]��:������Țg>o9H��Ɯ���b��p�P��W�:���ו<�t��g��e=������=)]���%�ez�<?��K{�
�����x�9=�*�Ď� 2,��L��k�N]�CЮ"�U�f�7�.�"��C|l�*=��Q}]�Ze� �x$�;��q��J2f�ΐR��U�͓R��}�¡�`]�C9���)t��/x��E7?p^�'����h:@��!��=t�a��鞚��q����D�� ��י23<����}.�B�З	1�(��˼�4��ٵ��H2��z�n��ra��^ּ܈ n^�$��"�����m�l���A9_ �.��z#����0u���;��c�t�v(��gT�Bѯ�GZ/h���FG���P�"T���M>u!��{N���М��"R�~}8�w���{��x��.��I��~�b�5���S���<�']Dz�[6.��q�������.��u-�tQ�M�J�U03���sEFj�$1��7��~ּ\<�A���I&>0e!e�.%���Jrd���s��v.G6;��w*��G�F��"�F�wq鱞=;���g��P�o��{�ދ�vQ�z%�Fo��� �|�a�L�ڠN�O������Hq֞4/�6�~/ڧ_E��RI&=b�+p_��..���ȿ�5����m�uM��	�Ţ��FYn�8I�<u[�8�)�����i<���sz�=��u��.�<^(�O]�Ɂm�l�#�bO8GV�A�l�V��Aܬ�>��ݭJ2�3�m:�!٩�M��DNѢ�N����2%j��77�M�bT�ҝf9��/���=b���]���/����k�M�x�D�(����_U��_�V#�^�.���k�e.��+6�ɪ�{�eșG�J.��1%8���H��Lx�p<��2:sѫ�o�՞�ޝR�ej���
��)�d��5nfI��;�O�Jk�9l0h2s���-��<2�r T�G܋J2�3�3�f�L�\����S��`��b�;K����|u_6:F����_�z]�?���y�^?��9ϖN����N���4?�����f�|ĥ��3�ߖ!g��GE��)� ��(�A��*���*�p�fˁ�OOU�utT�	���}
��GS!�o�en!�x��,f�����Ш5B[�]5- |�,�4�t��kM�L]��L�L5����,�Pzu�%��)�ت�Ո�+)��꽜@m�%/~���e��P����U����D�o%^� ;��ۢ�T;�c[2Kș-���+��ǻ3SXu�����pF��J2�c�x�)P�i��F���H2f;ߥ�d�s�ztS/릔�%G6t�|ଟ6�)�-s��e�t������j��7'��9󉴠y�<Z���Bڟ������枯˩���
�̕e���/Œ�>� �;�Ys�b^I���G���ق�����Fq��u���)�ء�b�k�(��_�SG�T�EZ"����gwl�~ە�5�-=]A�m��5���F<���V%�tZ�k���̺���1T1�
*�we���Z�#k6�U\��cJԬ��i�^l�8]K�8�Kӹ�t��^�#�"��Y��x���w�5&�,e��'�}��\���)Q�6�t�g$�B�%�#9D�����G$Q$���L����G$sH�?"y��wQȹ�t�a又��{�̆�{u�Y�0E�DI�G$v��I��v�O����|e��s�1;"z2RO��$!�;,���!���5�C����!ܐl�js۱m;qX�?"�C�$:Vs�Nt��C�o��'@�d���s"���Z�_e��W��Cm\�pnX�.z���Z��'��\x��P��[S��=�g����ݕ�{��%j��7�~Ur�Z�d��g?�f��7? ��$�:"Ysd�'fYՆ+�P�	���gJ�y��֨*�����M�2k⋖��֟�h���
��%�m�X����mS�'ogr�qM���ߩ$�)s[���ÍQ$�\W�C�4��q���H���������^�DE?p5c])r�gɇ�_V�t2KT�����Gː����x+��O����s"#]1��n����;.���)��p4]9�8��Z��,���ꦶ�TWPs���b��=(ɘ��z�v��9�m ��Уm��UR�o8�(3j�CWYIs]�y|z�K<��a2�t��6�D�^I9p~��B5�}�~�XS?c�<��g�>�t-h������G�7�D�d�#��D"C�X��XW�C-$�8���o�~�m���"(<$�H2�c�J�l`D��{F��:�^]~-�ynt6O]q%���m�C�!g6� �[<�\������{���*���˫ �Xn�%���V�A<Q��l��~b�ԳM� e�?��V2;�I7R-#?t}�{�����J�q?+~_��wX�����d��v]`E���7zy#j��U��5jAb��]�,��H���=�����E�U~���;�ߩxǕ�����q�Cfք�2�n��%b9��[����x�J��2�r�-�Z�I�r���湐C��ޗX�8�I�6��V�v�.���M��z�"���sI����ui`爇9+����
jś�V���̾s}�������
��V��� p]�%����7��ZJ2f��z_�{�Q%�-H�(���-H%�?�n�Y4l7�,��÷��NA<�����9��b�9^|��|��_���n�g�s�×�?�{Ͽ��P�r��Fg���ă!�e����OWy9�\�]��J���i^��`൮
���(��cmr楫z�z��L��]q�9�D�ڟ�΋��t]�y�1
t�h�v�A���e�'��,s�1����$еfZ����'��As��P��4�tM��8��EJ�<v�����4Db��G��F�2�7���
�>�@}��-n��5c�d�#�ⱡ�Z�d������EI&<b��c��	t�j��d�Q���d�C˗�:�j�@�}����k�A�<p�|�u�!g�@T���u"��W�~ˠ�N�`���o��Y��|r��?bx��Q�Ț_����G�JT�������	�D���HId
�Vu��@D'uH
$%"I?\��N͐ˍۯ�ՖOwˀ���y��=~�+f#��}?��E��j||���[1%*z�����'/��s]��,g<�7�N%����7��,�Ne�4�������u{r[�-���Y�<5R��{�H'�����YDX�Vv��﷝���t���<��'"���MQ�e�[q�!*�#�-�%'_q��y���M&3��Hl����h9���T<S�ȴ�W�j�\�%q��J0ّy��N�GI��~���۬�X��C���?>�tm��S=Ȝ���&�n��r��9�c�gɋu�w�~*6s!�r��R����f�6ґʔhޣ��-Q���'�d*���G��\��$(s�Z�s��viD�z���;�R�D#C���vcŮ�
]��
7��    �8�y�6�!g�]Wt/���m���H_T�k� �r��K-��MfK�{�f�B�%nS�в8	���H䐈Z�h���G$qHJ�T�R�p�rjL'�@�������m����bNL,ȹv&W�$(r��[���]��\�iS��� C�C���������$���8Ꟃxj��_9���v�� 	�h����=�q�� _ޞL��9�)���ԫx�$�b�ګxw�����^���X�ݙ��%�ʯ�ޫ�>���~���s�wP��P����r�@׌~Y�e�9k�+��R����L`�2�/T�	��e��G�#ſ���n�����zY�EO���8G�W�$�*s��]���d2e��]K�h]o�cl̀���)��S�f�L
;�9a�����]�!!&�����F,2��4�kY���H�J�A��^&��$��L�����~��H0��ߓ�p�)n(�+0%*F�I���8[p	ez�}ͨ���1��drm�#A:,C.P�s+=>���_j6�кQI&:b�k,Sp/�]`f�g�sz��%�zn�Z��f�t	j�q��g�D3E���8oÔh>@ݾ�<�94�q�=�5W�s[�k��.!BA�<v�sQ{#��yl��x��z��Z�f8+��)O�G�0J�uir��ו׉ ����սq���yqF��ڙr'�uj��T��b�a�ݕD�R1m�)�+ƙ�81T��� ��3��>�uir�^���n�d�#f<�p�}y�Fl�.�-�x���|����@��N�����c���%Еi����e�+�#Ҽ��HW���Mu����sl��蝈Y|�T=>r��J2f�y��-K����U�>�omDS�kА�7�M�J2f�n@�19�u!S\��8���4�T5�if)������{|<�SLW��e%�Rn4��!g��욒�J2�cf�]�Yרh}�z�UD>:海֩hm����ԑN��2I�к}8�4<I������Pk��>Ɏ5�{�W^W���/<L~�<�ӉC <^���=Wv�ɔ���j�"���Et�r�sƭE����Cd�lN����T�!��iW��S���b�#1�����m��^�tx�3��O�*#e��q2��]#,b�g� n>;�l9��k��oŚ��Qw�s��)Q��5�&����G���&ļ �s�������'����o{�v�VI�콁A�n]�v~��_e�6��VFn����e��e�@״{�{��ܬ�>�@�a��F�+�Y8Es���D�����#g��P#9�ЁN���]چ:�0��ON�,�}[�׹��w��/yȈU��|�o2����6��M����79�i{��~U5��׎e��#�C]�F���ͨ`J4�n�u�]��.ls�xp�+�l�هmB���Pc�q�S�}jT���L�ق�?�#2�����úT�I��Wm���f�|��\[<�D7����~!#�}�|�x}UD��i�5n�q�Er���0N�q��v5:�x���-�r,*��4/��狠� �������I+�ۺ��ƍ������԰��GY���#ZQ�*[�bA$�C4AҒ��v���Ie���ڎ3�u%/���;[������{�GШJB����������+-�r�O��#��[]q2X�<BzV�}vVS�s���i�\�����P�m�Mk������Vr���@�oiZ_�Gm��T	�#%1��t����ι �5|���Q�p��.gW�9����<�v$�,s#	8�$9OPp�%i�$IO�5���Z�F1�J	F�$c�tDp��tdZC���z��Z؜�5 �����<䭴%$Gy+�Z-'�"����j��g���0N5�q5���H�R�W�Ϩ��h��v�?�a�<ʞ'MO�σw�|I-�%��o�rN0�rFm�$/�9y7�H�s��~��O�����6R�QK4�;I�((k�zZ��E�w��Q� �l��l,��Z�eS�9��֗���"Àu.�h��d�z2]���x�XaIh�uG����x��)Ֆp����!ݩ��v��7���vx����D ��՟$��C�V���+�G��`Z�Ü{�sy�)��22n!c���I��l��~��\N�-F�h��N][��`���ۼ��$f�ԷU|�H��Tm$A�$��B�m�-��U���<��0����4����ϧO�i'ƻ�|:��Ә�2�5�8�9R~���w�/v�B�ܤ���F��`�0t�_�@p�+D@'! ��"�k ��?��"f{:%���x��E8�������ɤ$F|��؄R؜R'�X�̯�������|"��_�RIE�T���Wl��w3.��5�W�$�xR��8F��:C�ь���s�.��-��	L3)�9IT3��/�a�~	U�����J�+酠�����T�����{��a�$ʏ	���b� ��\Y�xق+��[K}�;[�����dLk��MO0ir,%1��-F}8^/NR��������c	4n���Dk�$n7�M��A�4!sJ��������_��}�21�B����M��������܃@���A�}��X����A5ku`�������@���l(a$�F�I� �+DcK	�l�##�]J0f�	�ys�l��4,����@`J���z/I��9ǃg��?e/@��0�w�����@I�S3�����a�]����?��yDc|�ʵU�|z��'�S�e|KyT�.��6�ç<������3�)>A��R���*|�*m��W�EYق?B׿��]4T3�ﶕ9^eÚ��������U�\���ťem��-�[�TQٙ�֞����wv/�����֡��~��!͜?A��TÇ��N��-���Ƶ�kۆ9&N�ň.LA�
q��5�����mQ~4Ì���D��@&�8IB4ګ���TID4ϲ��!:�OP��*�0k��=��
#`�>p��%���Z�a��K�
K%�ЃU��NhAX��ypI��䒏t�V�O����&�Շ+��ͥ�qzr.��&��=G[-�(?�;�4jF;&IK�i�'᫦�	*��� k�XUk<|

N����n&j��[���7���m�f<y6:�pj�w3��ȸ�K�Fr�����C�ۜ`��V�5��Z�Uk�{�!��l9�'@�>�����DJ0I�1ө��]�V��	��o��Ӊ�TLbB'����>A#τD�τ$�OP�U^ڤ~�س��1��U����ꢳG�m���$�O�9}��P�M�p�8UIE���n�g�r��(���ϫ�yT`	T����c��Q,�K4��U�QK����s�}�8�`>�ZRgG���O����0��O�Q0�ZU�&@�i�5祷s�g��g�y�MMg��l��Z�ј1l���bo����怠W{=�/�XU{=-�ygi�he$����u���$F3�U��J�˚��%�ڃ�_���(o�;'˵T�����ʄЦ�[;��go�:�q/����K���?��E�->�8FΛ�����x��w~^�ʍ��+z��o�X���Ζ�@l���<�Pu9A\-�Q����(����vo�(�>V���g�rΣW��<�w9 j��0ΰ�v��B�o�_ϳ���Jk��tޒ����w�(޳x��	��4��P��[|y����6�M�\ �~A�y��r<A���˱�k*8:������¾J��K�͋^���@ƣ;o޼(���^��zQ�^�������*�c	��ęv%Ů��ӫ[f��7�~��G�{$o^����|���7���N&���q��Qv6�\��G���'k�����c���X+��Z�%���������8ؠ<�=�\Jb|�y�N�5�oo����o��R�Q[�#�|-� N]�"C���{��>�=0������z��vW8iy�����P^�
�1��?�l5�xUM��
�7�����>�7x��Y��/<�s��+%���,;��o>��AT�z���W%���LbG   Y0�5���x�e��_<�t��gX���ͣ�|ɸխ��������q�1����p��7՜��x�d�}	x�q��|�v,��[};ُ���xH�qP Rq�����䔵����7O6(��ɛ�%��{K��L&���Ac��Ue��y��>����`̆�1����cv�<�4	(�@Նٸ�;�%����^:C;j��rJM1l�
�͇�`]�k�.�۽���x{����smN� ��͏*��f2k�͟:�?���������̥�{�߂��Kf�lq�tV�������q6��
���y��3g+4�k]!�<��|:�)�k]�ms��$x�޼�C~O������^���$�
J0>0��o^,�[��췘'{���5�z�`1��@���2��^� ��G֡0k����=�M�)@,�Z�ˋK/.�iMV<}}TL���#�~>ɘ!w�V��X�.����P�
Lb��<�)�}�3��g��z�;���G�?y�TBT�mjG�Q���-Z�v�$"��<�`�c.�;��Qa��"l';9�S��K��A���I�xIN�1�S�%z,ǹt�2l��ۜ��`Rc8����Wf���Q)���n����dNk�:���|q�',������a�(���䄜���@��[N�3�[�D@��:֫1yMB��I�b�#�6�>����I���3�����A��]���Ws�N��>����j��t�+�V��c`�񍵎{t,�H�xl8]�Kv�1�R�������h<�5ߛd9Oߕ��z��s^j)�{��äG(�Z���lIn؇R����+�ZpA�WX&���$I3��o\�Ѻ��(��n�����P��p����~9��[���>@D�e&߮5�>+�l�Z�N�|PP;�Y(�k��?#��=J0��,�OY�����<c�o2c^֡����?��PF2�@�5	b	T+\�j���c�g�?��Bx��(�����?��Bə�j`P���+�}�=��
a���7d�����
�Е1���ߡǲ����W�!��!�*Q����+�z��!mXɆ��C�H*R��6Q[��?�E� ��C��5�^j�~H�^s�S��Cڅ5�Bj�~H?��]Hm�����{���Ð���VjU���.q�1�K�� >��.�N��L ���L�.�] ���;ї
I�6������ޕ<���w�āL�1Ւ�X$���/ �x�/9_0�e7;��:���HCO:I�ѣ�O�	�L��4W��Q���6��Aw��x��9��%n�����èZl����o�Vk�*��Q1�<���b6z��6I���7o�P�/�v&�l��c]�*�O��i�P,K�B�W+��?L�
H�F/zNn�	b͞�dsq��%O0�D. ��}�����W��b�$����/�7�\߼�|�y��Ɋ�4�4�ټ��ds�����|��.����Ǜ�o>&�?u6o:�W��6��^��T�h�?CI��-��5��_n~�yM��R'1U�Ӎ�� ����s��ͯo^җ������eD֢c!�]X�����|�(���	��8��ºW�-�st.pb1�-��|N���FW�I&9^��ng�/�?l��\ӧ]�xB%�^X�Z
W+zAAn }k3_o��"�����Z�o��e�Z7�����{?�����w[֫u�Z׽%�M�̰ȋ�J;�f�? f��W��{oq>����v���G��C��!�-�7��CN�N�Ho�%Go���כ��h���	���?�p�N����;�w�L4��n-cX�e7:�9��6_�ڠm�t%��8G�,)c�~����U���%y���v��6�,��)ے.2���u!��3�_�B��8 ���1L|ε��ڳ+������*~I��G��/H�\OW�`$�+��/���Y�����io��7i+N$��L��H�ѵ���MT����7��%��i�^�E�|3��/�_�%"oo���N��0�;���/hcj⮘�n!>�v��d��FL��h[�-5��>�����6/�G<�Q2�O������u�p�������LyA`ﾂ�*�[T\M����.�gAɧ@�)œP� נ, ��:1�^z^ Lj���i&� د�� 5����T
8��n��N����$���]^ ���u��1/ �u�z^ �넣�壒�ur�l~E��t���N���ufW>�P�M�W��P+T_ F�¥��)�`i�_�e��/�d���qK���!��3_��%n~0:�H���)�-ɾŕ�"~~�Yu�i�����(����75�R��\�k�!)h�]W��"Ӵ�N�������:j��jIQ���ĳ�߅�%?<��n~�(���� �UO-�l*�O�{ݬ�(CU��N�+i�ɶ�ׁ̒��.����mw����;:��ڜ~������ǛOn~����M#��������s�:҃�OY�;j�?�����w�M����[8l_�M�^����i�dٹM��>%C�V�͚��;o�냠z;w��m��vf�A|�vm��6M��AG����UxP�ؿޝ����6��	�-��5y�H�$#Z��dBt����r{­b���S^�s�H�>/ v�']ܼJ��� נ�@o Fb��`�"	~��P �@� ��4�Au��G ���$kCDz�8��G�.��r�d�����IF��P�{rZ�����;��d{���菉�3���/��z�.�x�.Iw�]m��@�\!�<hQŭ��^�	������-���q?�0�NR���b̶7^���>���G�0o�;>і{ْr���Ǘ�I���R}G=�>���;��/w�`ۣ��1��cA���Ƽ ح�/ � �?��XA�/�	�BԻ~z�����;^�O	g,U��粒�:�зT=�$b����'��(�P�w*:w�ө��4C?��9��EyZ�3sP��F�Z�sU�#nQ��0����p#�z����Aqp&+~X��u�޽�.ex      �   X   x�3�4估�¦�M�]�sa��&�Ĳ����.#�Ԟ[/�콰�®8sS3�2�������6^��T���_����� �(*      �   �   x���D!C��s1;	�^��:&xu�D0?~sl�=�.�D�D��r�M�p�Nc�4(�oS��4��2�F���k�-GA2
��4���/�����1��1��x�տBF!�觷���7 ��?*n      �   q   x��M
@P���9�Q�vctsӍ(ɘ���A��5|wGΝ>o�O>aŁ'.��tٚ���)�������v�#x��v�H:o�#wlr��vʌ�Mʱ��Tŉ��?ѥ8      �     x�E�?JCA��}'Q䅙��};�'��L3�>�K+�`��*H���1`��0L�}�f}�V#��	3��)�c��%g�G��*1����.& &ks=b��#b�W�d��a���jrrV}�Ra_=[��G$R*����?����$�B��kq'���"tP"��hfݬf#N%Ǯ*UI������!���Q)�����X�h�*�io��}�۶�L{߿�]?|���ٶ������F���f.��YW7��Gs��\F�1��\��n�     