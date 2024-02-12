def fibs(num)
  array = [0, 1]
  i = 2
  while i < num
    array[i] = array[-1] + array[-2]
    i += 1
  end
  array
end

def fibs_rec(num, array = [])
  if num < 2
    return num
  else
    array << fibs_rec(num - 1) + fibs_rec(num - 2)
  end
  array
end