INSERT INTO roles (id, name) VALUES (1, 'ADMIN')    ON CONFLICT (id) DO NOTHING;
INSERT INTO roles (id, name) VALUES (2, 'CUSTOMER') ON CONFLICT (id) DO NOTHING;
INSERT INTO roles (id, name) VALUES (3, 'MERCHANT') ON CONFLICT (id) DO NOTHING;

SELECT setval(
    pg_get_serial_sequence('roles', 'id'),
    (SELECT COALESCE(MAX(id), 1) FROM roles)
);

-- Proveedores de servicios (catalogo del dominio billing)
INSERT INTO service_providers (id, name, category, active, created_at) VALUES
  (1, 'Sedapal',     'UTILITIES', true, now()),
  (2, 'Luz del Sur', 'UTILITIES', true, now()),
  (3, 'Movistar',    'TELECOM',   true, now()),
  (4, 'Claro',       'TELECOM',   true, now()),
  (5, 'Win',         'INTERNET',  true, now())
ON CONFLICT (id) DO NOTHING;

SELECT setval(
    pg_get_serial_sequence('service_providers', 'id'),
    (SELECT COALESCE(MAX(id), 1) FROM service_providers)
);
