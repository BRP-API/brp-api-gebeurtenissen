CREATE ROLE brp_gebeurtenissen_eigenaar;
ALTER
ROLE brp_gebeurtenissen_eigenaar WITH SUPERUSER LOGIN PASSWORD 'riot-antihero-moustache';

CREATE
DATABASE rvig_brpapi_projecties WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
ALTER
DATABASE rvig_brpapi_projecties OWNER TO brp_gebeurtenissen_eigenaar;
