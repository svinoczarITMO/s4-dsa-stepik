import java.util.Scanner;
import java.util.Stack;

public class Main {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        String s = in.nextLine();

        Stack<Integer> stack = new Stack<>();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '(' || c == '[' || c == '{') {
                stack.push(i);
            } else if (c == ')' || c == ']' || c == '}') {
                if (stack.isEmpty()) {
                    System.out.println(i + 1);
                    return;
                }
                char top = s.charAt(stack.pop());
                if ((top == '(' && c != ')') || (top == '[' && c != ']') || (top == '{' && c != '}')) {
                    System.out.println(i + 1);
                    return;
                }
            }
        }

        if (stack.isEmpty()) {
            System.out.println("Success");
        } else {
            System.out.println(stack.pop() + 1);
        }
    }
}