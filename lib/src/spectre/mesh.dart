/*
  Copyright (C) 2013 John McCutchan

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
*/

part of spectre;

class SpectreMeshAttribute {
  final String name;
  final VertexAttribute attribute;
  SpectreMeshAttribute(this.name, this.attribute);

  String toString() => '$name $attribute';
}

abstract class SpectreMesh extends DeviceChild {
  final Map<String, SpectreMeshAttribute> attributes =
      new Map<String, SpectreMeshAttribute>();
  int count = 0;
  int primitiveTopology = PrimitiveTopology.Triangles;
  SpectreMesh(String name, GraphicsDevice device)
      : super._internal(name, device);
  void finalize() {
    super.finalize();
  }
}

class SingleArrayMesh extends SpectreMesh {
  VertexBuffer _deviceVertexBuffer;
  VertexBuffer get vertexArray => _deviceVertexBuffer;

  SingleArrayMesh(String name, GraphicsDevice device) : super(name, device) {
    _deviceVertexBuffer = new VertexBuffer(name, device);
  }

  void finalize() {
    super.finalize();
    _deviceVertexBuffer.dispose();
    _deviceVertexBuffer = null;
    count = 0;
  }
}

class SingleArrayIndexedMesh extends SpectreMesh {
  VertexBuffer _deviceVertexBuffer;
  IndexBuffer _deviceIndexBuffer;
  IndexBuffer get indexArray => _deviceIndexBuffer;
  VertexBuffer get vertexArray => _deviceVertexBuffer;

  SingleArrayIndexedMesh(String name, GraphicsDevice device)
      : super(name, device) {
    _deviceVertexBuffer = new VertexBuffer(name, device);
    _deviceIndexBuffer = new IndexBuffer(name, device);
  }

  void finalize() {
    super.finalize();
    _deviceVertexBuffer.dispose();
    _deviceIndexBuffer.dispose();
    count = 0;
  }
}
