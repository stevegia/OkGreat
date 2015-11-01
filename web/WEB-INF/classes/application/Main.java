/**
 * 
 */
package application;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import jpaentities.TCSUser;
import jpaentities.TestingCenter;
import utils.Constants;

/**
 * @author Haseeb Shahid
 *
 */
public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("TestingCenterScheduler");
		EntityManager em = emf.createEntityManager();
		
		Query q = em.createQuery("SELECT t FROM TCSUser t");
		List<TCSUser> userList = q.getResultList();
		for (TCSUser user : userList) {
			System.out.println(user.toString());
		}
		
		/*TestingCenter tc = new TestingCenter(1, 64, 10, 30, 30);
		em.getTransaction().begin();
		em.persist(tc);
		em.getTransaction().commit();*/
		
		q = em.createQuery("SELECT t FROM TestingCenter t");
		List<TestingCenter> testingCenterList = q.getResultList();
		for (TestingCenter testingCenter : testingCenterList) {
			System.out.println(testingCenter.toString());
		}
	}

}
