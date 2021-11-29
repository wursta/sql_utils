SELECT 
	pg_class.oid,
	pg_namespace.nspname as schema_name,
	relname as table_name,
	pg_catalog.obj_description(pg_class.oid) as comment
FROM pg_class
INNER JOIN pg_namespace ON pg_namespace.oid = pg_class.relnamespace
WHERE pg_namespace.nspname IN ('public') AND pg_class.relkind IN ('r', 't')
ORDER BY relname