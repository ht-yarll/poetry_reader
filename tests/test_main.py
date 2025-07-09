import os
import pathlib
import shutil
import pytest
from unittest.mock import patch, MagicMock
from app.main import ocr_to_obsidian

@pytest.fixture
def test_images(tmp_path):
    # Cria imagens fake
    img1 = tmp_path / "O Teste-1.jpg"
    img2 = tmp_path / "O Teste-2.jpg"
    img3 = tmp_path / "Outro-1.jpg"
    img4 = tmp_path / "sem-titulo-1.jpg"
    img5 = tmp_path / "sem-titulo-2.jpg"
    img6 = tmp_path / "O Teste-3.jpg"
    img7 = tmp_path / "TestStrip .jpg"
    for img in [img1, img2, img3, img4, img5, img6, img7]:
        img.write_bytes(b"fake image content")
    return tmp_path

@patch("main.vision.ImageAnnotatorClient")
def test_grouping_and_file_creation(mock_vision_client, test_images, monkeypatch,tmp_path):
    output_dir = tmp_path / "output"
    output_dir.mkdir()
    # Monkeypatch template e target para usar o tmp_path
    monkeypatch.setattr("main.template", "*{title}*\n\n{verses}\n")
    monkeypatch.setattr("main.target", str(output_dir / "{file_name}.md"))

    # Mock Vision API response
    mock_response = MagicMock()
    mock_response.full_text_annotation.text = "Linha 1\nLinha 2"
    mock_vision_client.return_value.document_text_detection.return_value = mock_response

    # Executa a função
    ocr_to_obsidian(str(test_images))

    # Verifica se os arquivos foram criados corretamente
    files = list(output_dir.glob("*.md"))
    file_names = sorted([f.name for f in files])

    assert "O Teste.md" in file_names
    assert "Outro.md" in file_names
    assert "sem-titulo-1.md" in file_names
    assert "TestStrip.md" in file_names