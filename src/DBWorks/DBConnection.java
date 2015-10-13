/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DBWorks;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
//import static org.apache.tomcat.jni.User.username;

/**
 *
 * @author Ahmad
 */
public class DBConnection {
    static String mysJDBCDriver = /*"mysql2.cs.stonybrook.edu";  */  "com.mysql.jdbc.Driver";
    static String url = "jdbc:mysql://localhost:3306/testing_center_scheduler";
    static String username = "root";
    static String password = "admin";
    static java.sql.Connection myConnection = null;

    static PreparedStatement myPreparedStatement = null;
   
    public static ResultSet ExecQuery(String query){
        ResultSet myResultSet = null;
        System.out.println("Test");
        try{
            if(myConnection == null || (myConnection !=null && !myConnection.isValid(0)))
            {

                Class.forName(mysJDBCDriver).newInstance();
                myConnection = DriverManager.getConnection(url,username,password);
                System.out.println("myConnection");
            System.out.println(myConnection);
            }

            myPreparedStatement = myConnection.prepareStatement(query);
            System.out.println("myPreparedStatement");
            System.out.println(myPreparedStatement);
            myResultSet = myPreparedStatement.executeQuery();
            System.out.println("myResultSet");
            System.out.println(myResultSet);
            
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
    
    public static int ExecUpdateQuery(String query){
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
    }
}
