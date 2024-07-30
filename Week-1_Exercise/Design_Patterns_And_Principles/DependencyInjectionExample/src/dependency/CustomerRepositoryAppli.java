package dependency;
import java.util.HashMap;
import java.util.Map;

public class CustomerRepositoryAppli implements CustomerRepository {
    private final Map<Integer, Customer> customerDatabase = new HashMap<>();

    @Override
    public Customer findCustomerById(int id) {
        return customerDatabase.get(id);
    }

    @Override
    public void addCustomer(Customer customer) {
        customerDatabase.put(customer.getId(), customer);
    }

    public boolean customerExists(int id) {
        return customerDatabase.containsKey(id);
    }
}
