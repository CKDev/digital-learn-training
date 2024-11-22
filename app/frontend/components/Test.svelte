<script lang="ts">
  import Card, { Content } from '@smui/card';

  export let title: string = 'Card Title';
  export let subtitle: string = 'Subtitle';
  export let body: string = 'This is the body content of the card.';
</script>

<style>
  .card-container {
    max-width: 400px;
    margin: 20px auto;
  }
</style>

<div class="card-container">
  <Card>
    <div style="padding: 1rem;">
      <h2 class="mdc-typography--headline6" style="margin: 0;">
        {title}
      </h2>
      <h3 class="mdc-typography--subtitle2" style="margin: 0; color: #888;">
        {subtitle}
      </h3>
    </div>
    <Content>{body}</Content>
  </Card>
</div>