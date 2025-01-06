import React from "react";
import { EditorContent, useEditor } from "@tiptap/react";

import {
  LinkBubbleMenu,
  MenuButtonBold,
  MenuButtonBulletedList,
  MenuButtonEditLink,
  MenuButtonItalic,
  MenuButtonOrderedList,
  MenuButtonStrikethrough,
  MenuButtonUnderline,
  MenuControlsContainer,
  MenuDivider,
  MenuSelectHeading,
  RichTextEditor,
  LinkBubbleMenuHandler,
  ResizableImage,
} from "mui-tiptap";
import StarterKit from "@tiptap/starter-kit";
import Underline from "@tiptap/extension-underline";
import Link from "@tiptap/extension-link";

const TipTapEditor = ({ editorRef, initialContent }) => {
  return (
    <RichTextEditor
      ref={editorRef}
      extensions={[
        StarterKit,
        Underline,
        LinkBubbleMenuHandler,
        Link,
        ResizableImage,
      ]} // Or any Tiptap extensions you wish!
      content={initialContent} // Initial content for the editor
      renderControls={() => (
        <MenuControlsContainer>
          <MenuSelectHeading />
          <MenuDivider />
          <MenuButtonBold />
          <MenuButtonItalic />
          <MenuButtonUnderline />
          <MenuButtonStrikethrough />
          <MenuButtonOrderedList />
          <MenuButtonBulletedList />
          <MenuButtonEditLink />
        </MenuControlsContainer>
      )}
    >
      {() => (
        <>
          <LinkBubbleMenu />
        </>
      )}
    </RichTextEditor>
  );
};

export default TipTapEditor;
