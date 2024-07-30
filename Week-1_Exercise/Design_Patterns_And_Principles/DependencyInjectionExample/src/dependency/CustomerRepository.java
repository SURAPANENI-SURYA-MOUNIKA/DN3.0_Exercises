package dependency;
public interface CustomerRepository {
    Customer findCustomerById(int id);
    void addCustomer(Customer customer);
}
