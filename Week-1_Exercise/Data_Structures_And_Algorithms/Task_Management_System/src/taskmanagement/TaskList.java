package taskmanagement;

import java.util.ArrayList;
import java.util.List;

public class TaskList {
    
    private final List<Task> tasks;

    public TaskList() {
        tasks = new ArrayList<>();
    }

    public void addTask(Task task) {
        tasks.add(task);
    }

    public Task searchTask(int taskId) {
        for (Task task : tasks) {
            if (task.getTaskId() == taskId) {
                return task;
            }
        }
        return null;
    }

    public void traverseTasks() {
        for (Task task : tasks) {
            System.out.println(task);
        }
    }

    public boolean deleteTask(int taskId) {
        Task task = searchTask(taskId);
        if (task != null) {
            tasks.remove(task);
            return true;
        }
        return false;
    }
}
