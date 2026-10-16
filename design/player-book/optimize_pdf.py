#!/usr/bin/env python3
"""Compress embedded RGB artwork only; preserve text, links and alpha masks."""
import io, sys
from pypdf import PdfWriter
from pypdf.generic import NameObject
from PIL import Image

def optimize(source,target):
 writer=PdfWriter(clone_from=source);count=0
 for obj in writer._objects:
  if not hasattr(obj,'get') or obj.get('/Subtype')!='/Image':continue
  if obj.get('/ImageMask') or obj.get('/BitsPerComponent')!=8 or obj.get('/Filter')=='/DCTDecode':continue
  cs=obj.get('/ColorSpace')
  if hasattr(cs,'get_object'):cs=cs.get_object()
  rgb=cs=='/DeviceRGB' or (isinstance(cs,list) and cs[0]=='/ICCBased' and cs[1].get_object().get('/N')==3)
  if not rgb:continue # Preserve gray alpha masks and any other color model.
  size=(int(obj['/Width']),int(obj['/Height']));pixels=obj.get_data()
  if len(pixels)!=size[0]*size[1]*3:raise ValueError('Unexpected RGB artwork encoding')
  im=Image.frombytes('RGB',size,pixels);data=io.BytesIO();im.save(data,format='JPEG',quality=88,optimize=True)
  obj._data=data.getvalue()
  if hasattr(obj,'decoded_self'):obj.decoded_self=None
  obj[NameObject('/Filter')]=NameObject('/DCTDecode')
  obj.pop('/DecodeParms',None)
  count+=1
 writer.compress_identical_objects(remove_duplicates=True,remove_unreferenced=True)
 with open(target,'wb') as f:writer.write(f)
 print(f'Compressed {count} embedded artwork objects; preserved original resolution and alpha masks.')

if __name__=='__main__':optimize(sys.argv[1],sys.argv[2])
