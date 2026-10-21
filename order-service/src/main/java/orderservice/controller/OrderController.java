package orderservice.controller;

import orderservice.db.Order;
import orderservice.db.OrderRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
public class OrderController {

    private final OrderRepository orderRepository;

    // Зависимость внедряется автоматически через конструктор
    public OrderController(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    @GetMapping("/orders")
    public List<Order> getAllOrders() {
        // Запрос к этому методу сгенерирует SQL-логи, которые запишутся в примонтированный файл
        return orderRepository.findAll();
    }
}
