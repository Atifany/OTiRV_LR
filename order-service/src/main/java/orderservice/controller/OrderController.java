package orderservice.controller;

import orderservice.db.Order;
import orderservice.db.OrderRepository;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/orders")
public class OrderController {

    private final OrderRepository orderRepository;

    // Внедряем репозиторий через конструктор
    public OrderController(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    // Чтение
    @GetMapping
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    // Запись
    @PostMapping
    public Order createOrder(@RequestBody Order newOrder) {
        return orderRepository.save(newOrder);
    }
}
