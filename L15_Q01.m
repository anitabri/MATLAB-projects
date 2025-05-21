function[] = L15_Q01()
%Anita Britto

f = @(x) cos(x);
int = @(x) sin(x);
[a, b, e] = get_input;
[approx] = adaptive_quadrature(f, a, b, e);
fprintf('Adaptive quadrature with a = %.2f and b = %.2f gives %.6f\n',a,b, approx);
fprintf('The true integral with a = %.2f and b = %.2f is %.6f\n', a,b,(int(b)-int(a)));

abs_error = abs((int(b)-int(a))-approx);

fprintf('The absolute error in the approximation is %.6e\n', abs_error);
end

function[a, b, e] = get_input()
a = input('Enter a value for a: ');
b = input('Enter a value for b: ');
e = input('Enter a value for epsilon: ');

while e <=0
    fprintf('Invalid epsilon %.4f\n', e);
    e = input('Enter a value for epsilon: ');
end
end

function[approx] = adaptive_quadrature(f, a, b, e)

fprintf('adaptive_quadrature: Entering with a = %.6f and b = %.6f\n',...
    a,b);
c = (a+b)/2;
Qab = ((f(a) + f(b))/2)*(b-a);
Qac = ((f(a) + f(c))/2)*(c-a);
Qcb = ((f(c) + f(b))/2)*(b-c);
approx_error = (1/2)*abs(Qab-(Qac+Qcb));
if approx_error < e
    approx = Qac+Qcb;
else
     approx1 = adaptive_quadrature(f, a, c, e);
     approx2 = adaptive_quadrature(f, c, b, e);
     approx = approx1 + approx2;
end
end
