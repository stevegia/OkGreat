/**
 * 
 */
package application;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import jpaentities.TCSUser;

/**
 * @author Haseeb Shahid
 *
 */
public class Retriever {
	/*
	 * The singleton Retriever object. It will only get instantiated once in the lifetime of the program.
	 */
	private static Retriever singleton = null;
	
	// variables needed for JPA queries
	private static EntityManagerFactory emf;
	private static EntityManager em;
	private static Query query;
	
	/**
	 * Private class constructor. It will only get called once in the lifetime of the program.
	 * Instantiates EntityManagerFactory and EntityManager objects needed for JPA queries.
	 */
	private Retriever() {
		emf = Persistence.createEntityManagerFactory("TestingCenterScheduler");
		em = emf.createEntityManager();
	}
	
	/**
	 * Ensures the Retriever class is only initiated once.
	 * @return the singleton Retriever
	 */
	public static Retriever getInstance() {
		if(singleton == null)
			singleton = new Retriever();
		return singleton;
	}
	
	/**
	 * Queries the database for a TCSUser object with specified netId and password.
	 * @param netId
	 * @param password
	 * @return the TCSUser matching the parameters if present or null if not present
	 */
	public TCSUser getUser(String netId, String password) {
		try {
    		query = em.createQuery("SELECT t FROM TCSUser t WHERE t.netId = ?1 AND t.password = ?2");
    		query.setParameter(1, netId);
    		query.setParameter(2, password);
    		
    		// user exists in database
    		return (TCSUser) query.getSingleResult();
        } catch(Exception e) {
        	// user not found in database
        	return null;
        }
	}
}
