public class area {

  public float aWidth, aHeight, bWidth, bHeight, xPos, yPos;
  public boolean black = false;

  private area[] areas = new area[2];
  private spacer div;
  private renderarea renderframe;
  private area parent;

  private boolean mouseOver = false;
  private int curvemode = 0;

  private Point curve[] = new Point[4];
  private float angle = 0;

  private boolean adrag = false;

  float s = 20;

  public area(float x, float y, float w, float h, area p) {
    aWidth = w;
    aHeight = h;
    xPos = x;
    yPos = y;
    bWidth = 10;
    listeners.put(this.toString()+"bWidth", new OnChangeListener() {
      boolean wait = false;
      float save = bWidth;
      public void saveForRender() {
        wait = true;
        save = bWidth;
      }
      public void onChangeBy(int i) {
        if (!wait) {
          save = bWidth;
        }
        bWidth+=i;
        if (bWidth < 0) {
          bWidth = 0;
        }
      }
      public void onChange(Object o) {
        bWidth = (float)o;
      }
      public void onRender(boolean h) {
        render();
        if (h) {
          history.add(new Action(save, bWidth, this));
        }
        wait = false;
      }
    });
    bHeight = 10;
    listeners.put(this.toString()+"bHeight", new OnChangeListener() {
      boolean wait = false;
      float save = bHeight;
      public void saveForRender() {
        wait = true;
        save = bHeight;
      }
      public void onChangeBy(int i) {
        if (!wait) {
          save = bHeight;
        }
        bHeight+=i;
        if (bHeight < 0) {
          bHeight = 0;
        }
      }
      public void onChange(Object o) {
        bHeight = (float)o;
      }
      public void onRender(boolean h) {
        render();
        if (h) {
          history.add(new Action(save, bHeight, this));
        }
        wait = false;
      }
    });
    parent = p;
    if (p == null) {
      curvemode = 2;
    }
    listeners.put(this.toString()+"curvemode", new OnChangeListener() {
      boolean wait = false;
      float save = curvemode;
      public void saveForRender() {
        wait = true;
        save = curvemode;
      }
      public void onChangeBy(int i) { }
      public void onChange(Object o) {
        curvemode = (int)o;
      }
      public void onRender(boolean h) {
        render();
        if (h) {
          history.add(new Action(save, curvemode, this));
        }
        wait = false;
      }
    });
    renderframe = new renderarea(this);
    prints.add(this);

    curve[0] = new Point(x+(0.4*w), y+(h*0.4));
    listeners.put(this.toString()+"curve0", new OnChangeListener() {
      boolean wait = false;
      float savex = curve[0].x, savey = curve[0].y;
      public void saveForRender() {
        wait = true;
        savex = curve[0].x;
        savey = curve[0].y;
      }
      public void onChangeBy(int i) { }
      public void onChange(Object o) {
        curve[0] = (Point)o;
      }
      public void onRender(boolean h) {
        render();
        if (h) {
          history.add(new Action(new Point(savex, savey), curve[0], this));
        }
        wait = false;
      }
    });
    curve[1] = new Point(x+(0.45*w), y+(0.01*h));
    listeners.put(this.toString()+"curve1", new OnChangeListener() {
      boolean wait = false;
      float savex = curve[1].x, savey = curve[1].y;
      public void saveForRender() {
        wait = true;
        savex = curve[1].x;
        savey = curve[1].y;
      }
      public void onChangeBy(int i) { }
      public void onChange(Object o) {
        curve[1] = (Point)o;
      }
      public void onRender(boolean h) {
        render();
        if (h) {
          history.add(new Action(new Point(savex, savey), curve[1], this));
        }
        wait = false;
      }
    });
    curve[2] = new Point(x+(0.55*w), y+(0.99*h));
    listeners.put(this.toString()+"curve2", new OnChangeListener() {
      boolean wait = false;
      float savex = curve[2].x, savey = curve[2].y;
      public void saveForRender() {
        wait = true;
        savex = curve[2].x;
        savey = curve[2].y;
      }
      public void onChangeBy(int i) { }
      public void onChange(Object o) {
        curve[2] = (Point)o;
      }
      public void onRender(boolean h) {
        render();
        if (h) {
          history.add(new Action(new Point(savex, savey), curve[2], this));
        }
        wait = false;
      }
    });
    curve[3] = new Point(x+(0.6*w), y+(h*0.6));
    listeners.put(this.toString()+"curve3", new OnChangeListener() {
      boolean wait = false;
      float savex = curve[3].x, savey = curve[3].y;
      public void saveForRender() {
        wait = true;
        savex = curve[3].x;
        savey = curve[3].y;
      }
      public void onChangeBy(int i) { }
      public void onChange(Object o) {
        curve[3] = (Point)o;
      }
      public void onRender(boolean h) {
        render();
        if (h) {
          history.add(new Action(new Point(savex, savey), curve[3], this));
        }
        wait = false;
      }
    });
  }

  public void draw() {
    noStroke();
    strokeWeight(1);
    fill(vCol);
    float midx = xPos*scF+(aWidth/2)*scF;
    float midy = yPos*scF+(aHeight/2)*scF;
    if (curvemode != 1) {
      if (areas[0] != null && areas[1] != null) {
        areas[0].draw();
        areas[1].draw();
        if (!render) {
          div.draw();
        }
      } else {
        if (!render) {
          if (mouseOver) {
            fill(bgCol, 200);
            ellipse(midx, midy, 3.5*s, 3.5*s);
            rectMode(CENTER);
            rect(midx+s*2.25, midy, s, s*2.5, s/2);
            rect(midx, midy+s*2.25, s*2.5, s, s/2);
            rectMode(CORNER);
            fill(vCol);
            ellipse(midx-s, midy, s, s);
            ellipse(midx+s, midy, s, s);
            ellipse(midx, midy+s, s, s);
            stroke(bgCol);
            line(midx-(s*1.3), midy, midx-(s*0.7), midy);
            line(midx+s, midy-(s*0.3), midx+s, midy+(s*0.3));
            beginShape();
            vertex(midx, midy+(0.7*s));
            bezierVertex(midx-(s/3), midy+(0.9*s), midx+(s/3), midy+(1.1*s), midx, midy+(1.3*s));
            endShape();
            if (curvemode == 0) {
              line(midx+cos(QUARTER_PI)*(s/3), midy+s-cos(QUARTER_PI)*(s/3), midx-cos(QUARTER_PI)*(s/3), midy+s+cos(QUARTER_PI)*(s/3));
            }
            noStroke();
            ellipse(midx, midy-s, s, s);
            stroke(bgCol); 
            if (black) { 
              fill(0);
            } else { 
              fill(255);
            }
            ellipse(midx, midy-s, s/2, s/2);
            stroke(vCol);
            line(midx+(s*2), midy-(0.5*s), midx+(s*2.5), midy-(0.5*s));
            line(midx+(2.25*s), midy-(0.25*s), midx+(2.25*s), midy-(0.75*s));
            line(midx+(2*s), midy+(0.5*s), midx+(2.5*s), midy+(0.5*s));

            line(midx-(0.5*s), midy+(2*s), midx-(0.5*s), midy+(2.5*s));
            line(midx-(0.25*s), midy+(2.25*s), midx-(0.75*s), midy+(s*2.25));
            line(midx+(0.25*s), midy+(2.25*s), midx+(0.75*s), midy+(2.25*s));
          } else {
            fill(bgCol, 200);
            ellipse(midx, midy, s, s);
            fill(vCol);
            ellipse(midx, midy, s/2, s/2);
          }
        } else {
          renderframe.draw();
        }
      }
    } else {
      noFill();
      stroke(vCol);
      beginShape();
      vertex(curve[1].x*scF, curve[1].y*scF);
      bezierVertex(curve[0].x*scF, curve[0].y*scF, curve[3].x*scF, curve[3].y*scF, curve[2].x*scF, curve[2].y*scF);
      endShape();
      curve[0].draw(scF);
      curve[1].draw(scF);
      curve[2].draw(scF);
      curve[3].draw(scF);
      fill(vCol);
      stroke(bgCol);
      ellipse(midx, midy, s, s);
      noFill();
      beginShape();
      vertex(midx, midy-(0.3*s));
      bezierVertex(midx-(0.3*s), midy-(0.1*s), midx+(0.3*s), midy+(0.1*s), midx, midy+(0.3*s));
      endShape();
      stroke(vCol);
      arc(midx, midy, s*3, s*3, radians(angle)-QUARTER_PI, radians(angle)+QUARTER_PI);
      fill(255);
      ellipse(midx+(1.5*s)*cos(radians(angle)), midy+(1.5*s)*sin(radians(angle)), s, s);
    } 
    if (!render && areas[0] == null && areas[1] == null) {
      fill(bgCol);
      noStroke();
      rect(xPos*scF, yPos*scF, bWidth*scF, aHeight*scF);
      rect(xPos*scF, yPos*scF, aWidth*scF, bHeight*scF);
      rect(xPos*scF+aWidth*scF-bWidth*scF, yPos*scF, bWidth*scF, aHeight*scF);
      rect(xPos*scF, yPos*scF+aHeight*scF-bHeight*scF, aWidth*scF, bHeight*scF);
    }
  }

  public void getRenderData(renderarea r, boolean l) {
    if (curvemode == 0 && parent != null && l) {
      parent.getRenderData(r, l);
    } else {
      if (r != renderframe) {
        r.linesR = renderframe.linesR;
        r.linesL = renderframe.linesL;
        r.distance = renderframe.distance;
        r.steps = renderframe.steps;
        r.dotted = renderframe.dotted;
      }
    }
  }

  public void setRenderData(renderarea r, boolean l) {
    if (curvemode == 0 && parent != null && l) {
      parent.setRenderData(r, l);
    } else {
      if (r != renderframe) {
        renderframe.linesR = r.linesR;
        renderframe.linesL = r.linesL;
        renderframe.distance = r.distance;
        renderframe.steps = r.steps;
        renderframe.dotted = r.dotted;
      }
      render();
    }
  }

  public boolean ownC() {
    return curvemode != 0;
  }

  public Point[] getCurve() {
    if (curvemode != 0 || parent == null) {
      return curve;
    } else {
      return parent.getCurve();
    }
  }

  public float getAngle() {
    if (curvemode != 0 || parent == null) {
      return angle;
    } else {
      return parent.getAngle();
    }
  }

  public float time() {
    return renderframe.time;
  }

  public void divide(boolean h) {
    if (h) {
      div = new spacer(xPos+(aWidth/2), yPos+(aHeight/2), h, this);
      areas[0] = new area(xPos, yPos, aWidth, aHeight/2, this);
      areas[1] = new area(xPos, yPos + (aHeight/2), aWidth, aHeight/2, this);
      registerDiv(div, h);
    } else {
      div = new spacer(xPos+(aWidth/2), yPos+(aHeight/2), h, this);
      areas[0] = new area(xPos, yPos, aWidth/2, aHeight, this);
      areas[1] = new area(xPos+(aWidth/2), yPos, aWidth/2, aHeight, this);
      registerDiv(div, h);
    }
    prints.remove(this);
  }

  public boolean hasChild(area a) {
    if (areas[0] != null & areas[1] != null) {
      return a==areas[0]||a==areas[1]||areas[0].hasChild(a)||areas[1].hasChild(a);
    } else {
      return false;
    }
  }

  public void rebuild() {
    if (div != null) {
      if (div.horizontal) {
        hor.remove(div);
      } else {
        vert.remove(div);
      }
      div = null;
    }
    if (areas[0] != null) {
      areas[0].rebuild();
      areas[0] = null;
    }
    if (areas[1] != null) {
      areas[1].rebuild();
      areas[1] = null;
    }
    prints.remove(this);
  }

  public void getErrors() {
    if (areas[0] != null && areas[1] != null) {
      areas[0].getErrors();
      areas[1].getErrors();
    } else {
      renderframe.getErrors();
    }
  }
  
  public float[] getBounds(int mode) {
    float[] bounds = new float[2];
    if (mode == 1) {
      bounds[0] = 0;
      bounds[1] = aWidth/2;
    }
    if (mode == 2) {
      bounds[0] = 0;
      bounds[1] = aHeight/2;
    }
    if (mode == 3) {
      bounds[0] = 0;
      if (parent == null) {
        bounds[1] = 10000;
      } else {
        float spPos = parent.div.horizontal?parent.div.yPos:parent.div.xPos;
        if (parent.areas[0] == this) {
          
        } else {
          
        }
      }
    }
    if (mode == 4) {
      bounds[0] = 0;
      bounds[1] = 200;
    }
    return bounds;
  }

  public void transform(float n, boolean h) {
    if (h) {
      areas[0].aHeight = n-yPos;
      areas[1].aHeight = yPos+aHeight-n;
      areas[1].yPos = n;
      areas[0].subtransform(n, 'h');
      areas[1].subtransform(n, 'y');
    } else {
      areas[0].aWidth = n-xPos;
      areas[1].aWidth = xPos+aWidth-n;
      areas[1].xPos = n;
      areas[0].subtransform(n, 'w');
      areas[1].subtransform(n, 'x');
    }
  }

  public void subtransform(float n, char b) {
    if (div == null) {
      return;
    }
    switch (b) {
    case 'x':
      if (div.horizontal) {
        div.xPos = xPos+(aWidth/2);
        areas[0].aWidth = aWidth;
        areas[0].xPos = xPos;
        areas[1].aWidth = aWidth;
        areas[1].xPos = xPos;
        areas[0].subtransform(n, b);
        areas[1].subtransform(n, b);
      } else {
        areas[0].aWidth = areas[0].xPos+areas[0].aWidth-xPos;
        areas[0].xPos = xPos;
        areas[0].subtransform(n, b);
      }
      break;
    case 'y':
      if (!div.horizontal) {
        div.yPos = yPos+(aHeight/2);
        areas[0].aHeight = aHeight;
        areas[0].yPos = yPos;
        areas[1].aHeight = aHeight;
        areas[1].yPos = yPos;
        areas[0].subtransform(n, b);
        areas[1].subtransform(n, b);
      } else {
        areas[0].aHeight = areas[0].yPos+areas[0].aHeight-yPos;
        areas[0].yPos = yPos;
        areas[0].subtransform(n, b);
      }
      break;
    case 'w':
      if (div.horizontal) {
        div.xPos = xPos+(aWidth/2);
        areas[0].aWidth = aWidth;
        areas[1].aWidth = aWidth;
        areas[0].subtransform(n, b);
        areas[1].subtransform(n, b);
      } else {
        areas[1].aWidth = xPos+aWidth-areas[1].xPos;
        areas[1].subtransform(n, b);
      }
      break;
    case 'h':
      if (!div.horizontal) {
        div.yPos = yPos+(aHeight/2);
        areas[0].aHeight = aHeight;
        areas[1].aHeight = aHeight;
        areas[0].subtransform(n, b);
        areas[1].subtransform(n, b);
      } else {
        areas[1].aHeight = yPos+aHeight-areas[1].yPos;
        areas[1].subtransform(n, b);
      }
      break;
    }
  }


  public void render() {
    if (areas[0] != null && areas[1] != null) {
      areas[0].render();
      areas[1].render();
    } else {
      if (curvemode == 1) { 
        curvemode = 2;
      }
      renderframe.render();
      renderframe.generateGCode();
    }
  }

  void print(File folder) {
    if (areas[0] == null && areas[1] == null) {
      String[] out = renderframe.generateGCode();
      prints.add(this);
      int num = prints.size();
      saveStrings(folder.getAbsolutePath()+"/part_"+num+".nc", out);
    } else {
      areas[0].print(folder);
      areas[1].print(folder);
    }
  }
  
  void exportDimens(ByteArrayOutputStream b) {
    toByte((int)bWidth, b);
    toByte((int)bHeight, b);
    b.write(curvemode==0?0:1);
    for (int i = 0; i < 4; i++) {
      toByte((int)curve[i].x, b);
      toByte((int)curve[i].y, b);
    }
    toByte((int)angle, b);
    if (areas[0] != null && areas[1] != null) {
      b.write(1);
      b.write(div.horizontal?1:0);
      toByte((int)(div.horizontal?div.yPos:div.xPos), b);
      areas[0].exportDimens(b);
      areas[1].exportDimens(b);
    } else {
      b.write(0);
    }
  }
  
  void exportRender(ByteArrayOutputStream b) {
    b.write(black?0:1);
    toByte(renderframe.distance, b, 100);
    b.write(renderframe.linesL<0?0:1);
    toByte((int)abs(renderframe.linesL), b);
    b.write(renderframe.linesR<0?0:1);
    toByte((int)abs(renderframe.linesR), b);
    toByte((int)renderframe.steps, b);
    b.write(renderframe.linked?1:0);
    b.write(renderframe.dotted?1:0);
    if (areas[0] != null && areas[1] != null) {
      b.write(1);
      areas[0].exportRender(b);
      areas[1].exportRender(b);
    } else {
      b.write(0);
    }
  }
  
  public int build(byte[] b, int pos) {
    bWidth = toFloat(b[pos], b[pos+1], 1);
    bHeight = toFloat(b[pos+2], b[pos+3], 1);
    curvemode = (b[pos+4]==0?0:2);
    pos+=5;
    for (int i = 0; i < 4; i++) {
      curve[i].x = toFloat(b[pos+(i*4)], b[pos+(i*4)+1], 1);
      curve[i].y = toFloat(b[pos+(i*4)+2], b[pos+(i*4)+3], 1);
    }
    angle = toFloat(b[pos+16], b[pos+17], 1);
    pos+=18;
    if (b[pos]==1) {
      boolean h = b[pos+1]==1?true:false;
      float p = toFloat(b[pos+2], b[pos+3], 1);
      if (h) {
        div = new spacer(xPos+(aWidth/2), p, h, this);
        areas[0] = new area(xPos, yPos, aWidth, p-yPos, this);
        areas[1] = new area(xPos, p, aWidth, yPos+aHeight-p, this);
      } else {
        div = new spacer(p, yPos+(aHeight/2), h, this);
        areas[0] = new area(xPos, yPos, p-xPos, aHeight, this);
        areas[1] = new area(p, yPos, xPos+aWidth-p, aHeight, this);
      }
      registerDiv(div, h);
      prints.remove(this);
      pos = areas[0].build(b, pos+4);
      pos = areas[1].build(b, pos);
    } else {
      pos++; 
    }
    return pos;
  }
  
  public int buildRender(byte[] b, int pos) {
    black = b[pos]==0?true:false;
    renderframe.distance = toFloat(b[pos+1], b[pos+2], 100);
    renderframe.linesL = (int)toFloat(b[pos+4], b[pos+5], 1)*(b[pos+3]==1?1:-1);
    renderframe.linesR = (int)toFloat(b[pos+7], b[pos+8], 1)*(b[pos+6]==1?1:-1);
    renderframe.steps = (int)toFloat(b[pos+9], b[pos+10], 1);
    renderframe.linked = b[pos+11]==1?true:false;
    renderframe.dotted = b[pos+12]==1?true:false;
    if (b[pos+13]==1) {
      pos = areas[0].buildRender(b, pos+14);
      pos = areas[1].buildRender(b, pos);
    } else {
      pos+=14;
    }
    return pos;
  }

  public void mouseMoved(float mx, float my) {
    if (areas[0] != null && areas[1] != null) {
      areas[0].mouseMoved(mx, my);
      areas[1].mouseMoved(mx, my);
      div.mouseMoved(mx, my);
    } else {
      if (!mouseOver && sqrt(sq(mx-(xPos+(aWidth/2)))+sq(my-(yPos+(aHeight/2)))) <= s/2/scF) {
        mouseOver = true;
      }
      if (mouseOver && sqrt(sq(mx-(xPos+(aWidth/2)))+sq(my-(yPos+(aHeight/2)))) > s*3/scF) {
        mouseOver = false;
      }
      renderframe.mouseMoved(mx, my);
    }
    if (curvemode == 1) {
      curve[0].hover(mx, my);
      curve[1].hover(mx, my);
      curve[2].hover(mx, my);
      curve[3].hover(mx, my);
    }
  }

  public void mouseClicked(float mx, float my) {
    if (areas[0] != null && areas[1] != null) {
      areas[0].mouseClicked(mx, my);
      areas[1].mouseClicked(mx, my);
      div.mouseClicked(mx, my);
    } else {
      if (mouseOver && !render) {
        if (sqrt(sq(mx-(xPos+(aWidth/2)-(s/scF)))+sq(my-(yPos+(aHeight/2)))) <= s/2/scF) {
          divide(true);
        }
        if (sqrt(sq(mx-(xPos+(aWidth/2)+(s/scF)))+sq(my-(yPos+(aHeight/2)))) <= s/2/scF) {
          divide(false);
        }
        if (sqrt(sq(mx-(xPos+(aWidth/2)))+sq(my-(yPos+(aHeight/2)-(s/scF)))) <= s/2/scF) {
          black = !black;
        }
        if (sqrt(sq(mx-(xPos+(aWidth/2)))+sq(my-(yPos+(aHeight/2)+(s/scF)))) <= s/2/scF) {
          curvemode = (curvemode+1)%3;
          if (parent == null && curvemode == 0) {
            curvemode = 1;
          }
        }
        if (sqrt(sq(mx-(xPos+(aWidth/2)+(2.25*s/scF)))+sq(my-(yPos+(aHeight/2)-(0.5*s/scF)))) <= s/2/scF) {
          bHeight++;
        }
        if (sqrt(sq(mx-(xPos+(aWidth/2)+(2.25*s/scF)))+sq(my-(yPos+(aHeight/2)+(0.5*s/scF)))) <= s/2/scF) {
          bHeight--;
          if (bHeight < 0) { 
            bHeight = 0;
          }
        }
        if (sqrt(sq(mx-(xPos+(aWidth/2)-(0.5*s/scF)))+sq(my-(yPos+(aHeight/2)+(2.25*s/scF)))) <= s/2/scF) {
          bWidth++;
        }
        if (sqrt(sq(mx-(xPos+(aWidth/2)+(0.5*s/scF)))+sq(my-(yPos+(aHeight/2)+(2.25*s/scF)))) <= s/2/scF) {
          bWidth--;
          if (bWidth < 0) { 
            bWidth = 0;
          }
        }
      }
      if (curvemode == 1 && !render) {
        if (sqrt(sq(mx-(xPos+(aWidth/2)))+sq(my-(yPos+(aHeight/2)))) < s/2/scF) {
          curvemode = 2;
        }
      }
      renderframe.mouseClicked(mx, my);
    }
  }

  public void mousePressed(float mx, float my) {
    if (areas[0] != null && areas[1] != null && !render) {
      areas[0].mousePressed(mx, my);
      areas[1].mousePressed(mx, my);
      div.mousePressed(mx, my);
    }
    if (curvemode == 1) {
      curve[0].press(mx, my);
      curve[1].press(mx, my);
      curve[2].press(mx, my);
      curve[3].press(mx, my);
      if (sqrt(sq(mx-(xPos+(aWidth/2)+cos(radians(angle))*(1.5*s/scF)))+sq(my-(yPos+(aHeight/2)+sin(radians(angle))*(1.5*s/scF)))) < s/2/scF) {
        adrag = true;
      }
    }
  }

  public void mouseReleased(float mx, float my) {
    if (areas[0] != null && areas[1] != null) {
      areas[0].mouseReleased(mx, my);
      areas[1].mouseReleased(mx, my);
      div.mouseReleased(mx, my);
    }
    adrag = false;
  }

  public void mouseDragged(float mx, float my) {
    if (areas[0] != null && areas[1] != null && !render) {
      areas[0].mouseDragged(mx, my);
      areas[1].mouseDragged(mx, my);
      div.mouseDragged(mx, my);
    }
    if (curvemode == 1) {
      curve[0].press(mx, my);
      curve[1].press(mx, my);
      curve[2].press(mx, my);
      curve[3].press(mx, my);
      if (adrag) {
        float r = sqrt(sq(mx - (xPos+(aWidth/2))) + sq(my - (yPos+(aHeight/2))));
        if ((yPos+(aHeight/2)) > my) { 
          angle = degrees(acos((float)((xPos+(aWidth/2)) - mx)/(r))) + 180;
        } else {
          angle = degrees(acos((float)((xPos+(aWidth/2)) - mx)/(-r)));
        }
      }
    }
  }

  public void keyPressed() {
    if (areas[0] != null && areas[1] != null) {
      areas[0].keyPressed();
      areas[1].keyPressed();
      div.keyPressed();
    }
  }
}