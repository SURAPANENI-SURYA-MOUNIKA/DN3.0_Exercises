package dependency;
public class CustomerService {
    private final CustomerRepository customerRepository;

    public CustomerService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    public Customer getCustomerById(int id) {
        return customerRepository.findCustomerById(id);
    }

    public void addCustomer(Customer customer) {
        customerRepository.addCustomer(customer);
    }

    public boolean customerExists(int id) {
        return ((CustomerRepositoryAppli) customerRepository).customerExists(id);
    }
}
