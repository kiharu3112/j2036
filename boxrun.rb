require 'dxruby'

Window.width  = 600
Window.height = 500

start = 0
stop = 0
mode = 0
num = 0
num2= 0
num3 = 0
num_high = 0
back_num = 0
back_x = [620,620]
interval_back = 700
enemy_num = 0
random_enemy  = 0
enemy_number = [0,0,0]
enemy = []
interval_enemy = 0
box_Y = 370
image = 0
jump = 0
power = 0
v0 = 17

stage = Image.load('stage.png')
back = Image.load('back.png')
box_0_image = Image.load('box_0.png')
box_1_image = Image.load('box_1.png')
box_0_hit_image = Image.load('box_0_hit.png')
box_1_hit_image = Image.load('box_1_hit.png')
box_image = Image.load('box.png')
enemy_image = Image.load('enemy.png')
gameover = Image.load('457.png')

Window.loop do
  if mode == 0
    Window.draw(0,-22, stage)
    box = Sprite.new(30,box_Y,box_image)
    if Input.key_push?(K_SPACE) || Input.key_push?(K_UP)
      start = 1
    end
    if start == 1
      power += 1
      box_Y = box_Y - (v0 - power)
      if box_Y == 370
        power = 0
        mode = 1
      end
    end
    box.draw

  elsif mode == 1
    if stop == 0
      #back
      Window.draw(0, -22, stage)
      if interval_back == 700
        if back_num != 2
          back_num += 1
        end
        interval_back = 0
      end
      if back_num != 0
        while back_num > num2
          back_x[num2] -= 0.5
          if back_x[num2] > -20
            if num2 == 1
              Window.draw(back_x[num2],60,back)
            else
              Window.draw(back_x[num2],30,back)
            end
          else
            back_x[num2] = 620
          end
          num2 += 1
        end
        num2 = 0
      end
      interval_back += 1
      Window.draw_font(550, 0, "#{num}", Font.new(24),:color => C_BLACK)
      Window.draw_font(460, 0, "#{num_high}", Font.new(24),:color => C_BLACK)
      Window.draw_font(430, 0, "HI:", Font.new(24),:color => C_BLACK)

      #box
      if num % 7 == 0
        image += 1
      end
      num += 1
      if image % 2 == 0
        box = Sprite.new(30,box_Y,box_0_image)
      elsif
      box = Sprite.new(30,box_Y,box_1_image)
      end
      if jump == 0
        if Input.key_push?(K_SPACE) || Input.key_push?(K_UP)
          jump = 1
        end
      end
      if jump == 1
        power += 1
        box_Y = box_Y - (v0 - power)
        if box_Y == 370
          jump = 0
          power = 0
        end
      end
      box.draw

      #enemy
      if interval_enemy == 0
        random_enemy = rand(40..90)
      end
      if interval_enemy == random_enemy
        enemy_number[enemy_num%3] = 1
        enemy[enemy_num%3] = Sprite.new(700,380,enemy_image)
        enemy_num += 1
        interval_enemy = 0
        random_enemy  = rand(30..90)
      end
      interval_enemy+= 1
      if enemy_num >= 1
        while num3 < 3
          if enemy_number[num3] == 1
            enemy[num3].x -= 8
            enemy[num3].draw
            if  enemy[num3] === box || enemy[num3].x <= -40
              if enemy[num3] === box
                stop = 1
                break
              else
                enemy_number[num3] = 0
                enemy[num3].x = 700
              end
            end
          end
          num3 += 1
        end
        num3 = 0
      end

    elsif stop == 1
      #back
      Window.draw(0,-22, stage)
      while back_num > num2
        if num2 == 1
          Window.draw(back_x[num2],60,back)
        else
          Window.draw(back_x[num2],30,back)
        end
        num2 += 1
      end
      num2 = 0
      Window.draw_font(550, 0, "#{num}", Font.new(24),:color => C_BLACK)

      #box
      if image%2 == 0
        box = Sprite.new(30,box_Y,box_0_hit_image)
      else
        box = Sprite.new(30,box_Y,box_1_hit_image)
      end
      box.draw

      #enemy
      while num3 < 3
        if enemy_number[num3] == 1
          enemy[num3].draw
        end
        num3 += 1
      end
      num3 = 0

      #gameover
      Window.draw_font(230, 200, "PUSH  SPACE", Font.new(24),:color => C_BLACK)
      Window.draw(260,240,gameover)
      if num >= num_high
        num_high = num
      end
      Window.draw_font(460, 0, "#{num_high}", Font.new(24),:color => C_BLACK)
      Window.draw_font(430, 0, "HI:", Font.new(24),:color => C_BLACK)

      if Input.key_push?(K_SPACE) || Input.key_push?(K_UP)
        box_Y = 370
        num = 0
        interval_enemy = 0
        enemy_num = 0
        enemy_number = [0,0,0]
        jump = 0
        power = 0
        stop = 0
        mode = 1
      elsif Input.key_push?(K_ESCAPE)
        break
      end
    end
  end
end