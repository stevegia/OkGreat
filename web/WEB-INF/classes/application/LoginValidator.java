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
public class LoginValidator {
	public static TCSUser validate(String netId, String password) {
		try {
			System.out.println("before EMF");
        	EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestingCenterScheduler");
    		EntityManager em = emf.createEntityManager();
			System.out.println("After EMF");
    		Query query = em.createQuery("SELECT t FROM TCSUser t WHERE t.netId = ?1 AND t.password = ?2");
    		query.setParameter(1, netId);
    		query.setParameter(2, password);
			TCSUser user = (TCSUser) query.getSingleResult();
			System.out.println(query.toString());


    		return user ;
        } catch(Exception e) {
        	return null;
        }
	}
}
