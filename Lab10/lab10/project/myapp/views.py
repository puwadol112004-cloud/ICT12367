from django.shortcuts import render

def index(request):
    # แก้ไข/เพิ่มรายชื่อและอายุใน List นี้ได้เลยครับ
    people_data = [
        {'pid': 1, 'name': 'ภูวดล ศรสุคนแก้ว', 'age': 20},
        {'pid': 2, 'name': 'จักรภัทร นุ่นยัง', 'age': 28},
        {'pid': 3, 'name': 'มนธรรม คนหลัก', 'age': 31},
        {'pid': 4, 'name': 'อาร์ดีฟ สุระกำแหง', 'age': 29},
    ]
    return render(request, 'index.html', {'people': people_data})

def register(request):
    return render(request, 'form.html')

def about(request):
    return render(request, 'about.html')