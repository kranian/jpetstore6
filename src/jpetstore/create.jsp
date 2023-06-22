<%@ page session="true"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<html>
<body>
<%!
public Connection getConnection() throws Exception {
	//DataSource datasource = (DataSource) new InitialContext().lookup("java:/comp/env/jdbc/hsql");
    return DriverManager.getConnection("jdbc:hsqldb:mydatabase","SA","");
	//return datasource.getConnection();
}

public void make(String table)throws Exception {

    Connection conn = getConnection();
	Statement stmt = conn.createStatement();
    stmt.executeUpdate("CREATE TABLE "+table+" ( id varchar(40) ,name varchar(40) )");
    for(int  i = 0 ; i<10; i++){
       stmt.executeUpdate("insert into "+table+"(id,name) values('id"+i+"','name"+i+"')" );
    }
    conn.close();
}

public void drop(String table)throws Exception {

    Connection conn = getConnection();
	Statement stmt = conn.createStatement();
	try{
	  stmt.executeUpdate("drop table "+table);
	} catch(Exception e){

	}
    conn.close();
}

public void service() throws Exception {
    Random rand = new Random();

    Connection conn = getConnection();
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("select * from scouter");
    while (rs.next()) {
        String id = rs.getString(1);
        String name = rs.getString(2);
    }
    rs.close();
    stmt.close();
    conn.commit();
    conn.close();

    if (rand.nextInt(100) == 1) {
        Thread.sleep(rand.nextInt(20000));
    } else if (rand.nextInt(10) == 1) {
        Thread.sleep(rand.nextInt(1500));
    } else if (rand.nextInt(5) == 1) {
        Thread.sleep(rand.nextInt(5000));
    } else if (rand.nextInt(10) == 1) {
        Thread.sleep(rand.nextInt(1000));
    }
}


%>

<%

   make("scouter");
   service();
   make("master");
   make("dept");
   make("emp");
   drop("scouter");
   drop("master");
   drop("dept");
   drop("emp");
	
%>	
create ok
</body>
</html>
