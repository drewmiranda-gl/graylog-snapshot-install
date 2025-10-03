
rm -rf __pycache__
rm requirements.txt

source venv/bin/activate

python3 -m pip install pipreqs
python3 -m  pipreqs.pipreqs --encoding utf-8 .

deactivate