
while 1
    w = waitforbuttonpress;
    if w
        p = get(gcf, 'CurrentCharacter');
        disp(p) %displays the character that was pressed
        disp(double(p))  %displays the ascii value of the character that was pressed
    end
end