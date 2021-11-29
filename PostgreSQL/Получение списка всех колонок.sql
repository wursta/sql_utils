SELECT 
	attrelid::regclass AS table_name,
	attname            AS column_name, 
	pg_catalog.col_description(attrelid, attnum) as column_comment,
	atttypid::regtype  AS column_datatype
FROM pg_attribute
INNER JOIN pg_class ON pg_class.oid = attrelid
WHERE attrelid IN (
	SELECT pg_class.oid
	FROM pg_class
	INNER JOIN pg_namespace ON pg_namespace.oid = pg_class.relnamespace
	WHERE pg_namespace.nspname = 'public' AND pg_class.relkind IN ('r', 't')	
)
AND attnum > 0 AND attisdropped IS FALSE
ORDER BY pg_class.relname, pg_attribute.attnum