/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DBWorks;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnection {

    // JDBC parameters
    static String mysJDBCDriver =  "com.mysql.jdbc.Driver";
    static String url = "jdbc:mysql://localhost:3306/test_center_scheduler";
    static String username = "root";
    static String password = "admin123";
    static java.sql.Connection myConnection = null;

    // Used to hold the query and execute it
    static PreparedStatement myPreparedStatement = null;

    /* Method for executing MySQL queries from JSP files */
    public static ResultSet ExecQuery(String query) throws IOException {


        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        Properties properties = new Properties();
        properties.load(classLoader.getResourceAsStream("basic/okgreat/mysqlconfig.properties"));
        username = properties.getProperty("username");
        password = properties.getProperty("password");
        url = properties.getProperty("url");

        System.out.println(username);
        System.out.println(password);
        System.out.println(url);





        ResultSet myResultSet = null;

        try{
            if(myConnection == null || (myConnection !=null && !myConnection.isValid(0)))
            {
                Class.forName(mysJDBCDriver).newInstance();
                myConnection = DriverManager.getConnection(url,username,password);
                System.out.println("myConnection");
            System.out.println(myConnection);
            }
            System.out.println(query);
            myPreparedStatement = myConnection.prepareStatement(query);

            myResultSet = myPreparedStatement.executeQuery();

            
        } catch(ClassNotFoundException e)
        {
        }
        catch (SQLException e){
        } catch (InstantiationException ex) {
            System.out.println(ex);
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
        return  myResultSet;
    }

    /*public static int ExecUpdateQuery(String query){
       int retValue = 0;
        try{
            if(myConnection == null || (myConnection !=null && !myConnection.isValid(0)))
            {
                Class.forName(mysJDBCDriver).newInstance();
                myConnection = DriverManager.getConnection(url,username,password);
            }
            myPreparedStatement = myConnection.prepareStatement(query);
            retValue = myPreparedStatement.executeUpdate();
            
        } catch(ClassNotFoundException e)
        {
        }
        catch (SQLException e){
        } catch (InstantiationException ex) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
        return  retValue;
    }*/
}
