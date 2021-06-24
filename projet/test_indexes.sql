\i prepare.sql

\i delete_indexes.sql

EXPLAIN ANALYSE EXECUTE sans_masque ('FRA');

\i create_indexes.sql

EXPLAIN ANALYSE EXECUTE sans_masque ('FRA');

-----------------

\i delete_indexes.sql


EXPLAIN ANALYSE EXECUTE masque ('FRA');

\i create_indexes.sql


EXPLAIN ANALYSE EXECUTE masque ('FRA');


----------------------


\i delete_indexes.sql

EXPLAIN ANALYSE EXECUTE depasser('USA',100000);

\i create_indexes.sql

EXPLAIN ANALYSE EXECUTE depasser('USA',100000);

----------------------


\i delete_indexes.sql

EXPLAIN ANALYSE EXECUTE dc_depasser('USA',100000);

\i create_indexes.sql

EXPLAIN ANALYSE EXECUTE dc_depasser('USA',100000);


----------------------


\i delete_indexes.sql

EXPLAIN ANALYSE EXECUTE conf_max;

\i create_indexes.sql

EXPLAIN ANALYSE EXECUTE conf_max;



----------------------


\i delete_indexes.sql

EXPLAIN ANALYSE EXECUTE masque_max;

\i create_indexes.sql

EXPLAIN ANALYSE EXECUTE masque_max;


----------------------


\i delete_indexes.sql

EXPLAIN ANALYSE EXECUTE respecte;

\i create_indexes.sql

EXPLAIN ANALYSE EXECUTE respecte;


----------------------


\i delete_indexes.sql

EXPLAIN ANALYSE EXECUTE dist_depasser_all(20);

\i create_indexes.sql

EXPLAIN ANALYSE EXECUTE dist_depasser_all(20);

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
